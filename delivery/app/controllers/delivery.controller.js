const db = require("../models");
const Delivery = db.deliveries;
const Op = db.Sequelize.Op;
const User = db.users;
const Status = db.statuses;
const path = require('path');
const DeliveryItem = db.delivery_items;
const Order = db.orders;
const Good = db.goods;
const cloudinary = require('../config/cloudinary');
const fs = require('fs');
const Bulk = db.bulks;

exports.upload = async (req, res) => {
  try {
    const { delivery_id, image } = req.body;
    console.log("Delivery ID:", delivery_id);

    if (!image) {
      return res.status(400).json({ success: false, message: "No base64 image provided" });
    }

    // Decode base64 and write to temp file
    const buffer = Buffer.from(image, 'base64');
    const tempPath = path.join(__dirname, `../../tmp/${Date.now()}.png`);
    fs.writeFileSync(tempPath, buffer);

    const delivery = await Delivery.findByPk(delivery_id);
    if (!delivery) {
      return res.status(404).json({ success: false, message: "Delivery not found" });
    }

    const result = await cloudinary.uploader.upload(tempPath, {
      folder: 'deliveries',
      transformation: [
        { width: 1000, crop: "scale" },
        { quality: "auto" },
        { fetch_format: "auto" },
      ],
    });

    fs.unlinkSync(tempPath); // remove temp file

    delivery.image = result.secure_url;
    await delivery.save();

    res.status(200).json({ success: true, message: "Image uploaded", image: result.secure_url });

  } catch (err) {
    console.error("🔥 Image upload failed!");
    console.error("Message:", err.message);
    console.error("Stack:", err.stack);
    res.status(500).json({ success: false, message: "Server error", error: err.message });
  }
};


// In delivery.controller.js - add this function

exports.updateBulkAmount = async (req, res) => {
  try {
    const { id } = req.params;
    const { amount } = req.body;

    // Validate input
    if (amount === undefined || amount === null) {
      return res.status(400).json({
        success: false,
        message: "Amount is required"
      });
    }

    // Convert to number and validate
    const amountNum = parseFloat(amount);
    if (isNaN(amountNum)) {
      return res.status(400).json({
        success: false,
        message: "Amount must be a valid number"
      });
    }

    // Update the bulk record in your database
    // This depends on your database setup - here's an example using a hypothetical model
    const updatedBulk = await Bulk.update(
      { amount: amountNum },
      { where: { id: id } }
    );

    if (updatedBulk[0] === 0) {
      return res.status(404).json({
        success: false,
        message: "Bulk record not found"
      });
    }

    res.json({
      success: true,
      message: "Amount updated successfully",
      data: { id, amount: amountNum }
    });

  } catch (error) {
    console.error("Error updating bulk amount:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
      error: error.message
    });
  }
};

// Add this function to your delivery.controller.js
exports.updateBulkDiff = async (req, res) => {
  try {
    const { id } = req.params;
    const { diff } = req.body;

    if (diff === undefined) {
      return res.status(400).json({
        success: false,
        message: "Diff value is required"
      });
    }

    // Update the bulk record with new diff value
    const result = await Bulk.update(
      { diff: diff },
      { where: { id: id } }
    );

    if (result[0] === 0) {
      return res.status(404).json({
        success: false,
        message: "Bulk record not found"
      });
    }

    res.json({
      success: true,
      message: "Diff updated successfully"
    });
  } catch (error) {
    console.error("Error updating bulk diff:", error);
    res.status(500).json({
      success: false,
      message: "Error updating diff",
      error: error.message
    });
  }
};

exports.dailyClosing = async (req, res) => {
  const t = await db.sequelize.transaction();

  try {
    // ✅ Take date from query (default: today)
    const dateParam = req.query.date ? new Date(req.query.date) : new Date();
    const reportDate = new Date(dateParam); // keep this separate
    const startOfDay = new Date(reportDate.setHours(0, 0, 0, 0));
    const endOfDay = new Date(reportDate.setHours(23, 59, 59, 999));

    // 1️⃣ Get all deliveries for that day
    const deliveries = await Delivery.findAll({
      where: {
        delivered_at: { [Op.between]: [startOfDay, endOfDay] },
        is_deleted: false,
      },
      raw: true,
    });

    if (!deliveries.length) {
      await t.rollback();
      return res.status(200).json({
        success: true,
        message: "No deliveries found for that day.",
      });
    }

    const driverGroup = {};
    const merchantGroup = {};

    // 2️⃣ Group data by driver and merchant
    for (const d of deliveries) {
      // 👷 Driver summary
      if (d.driver_id) {
        if (!driverGroup[d.driver_id]) {
          driverGroup[d.driver_id] = {
            driver_id: d.driver_id,
            count: 0,
            delivered_count: 0,
            amount: 0,
            diff: 0,
          };
        }
        driverGroup[d.driver_id].count += 1;
        driverGroup[d.driver_id].amount += parseFloat(d.price || 0);
        if (d.status === 3) driverGroup[d.driver_id].delivered_count += 1;
      }

      // 🏢 Merchant summary
      if (d.merchant_id) {
        if (!merchantGroup[d.merchant_id]) {
          merchantGroup[d.merchant_id] = {
            merchant_id: d.merchant_id,
            count: 0,
            delivered_count: 0,
            amount: 0,
            diff: 0,
          };
        }
        merchantGroup[d.merchant_id].count += 1;
        merchantGroup[d.merchant_id].amount += parseFloat(d.price || 0);
        if (d.status === 3) merchantGroup[d.merchant_id].delivered_count += 1;
      }
    }

    // 3️⃣ Insert driver summaries
    for (const id in driverGroup) {
      const g = driverGroup[id];
      const paid = g.amount - g.diff;
      await Bulk.create(
        {
          driver_id: g.driver_id,
          merchant_id: null,
          count: g.count,
          delivered_count: g.delivered_count,
          amount: g.amount,
          diff: g.diff,
          paid,
          report_date: startOfDay, // ✅ save report date
        },
        { transaction: t }
      );
    }

    // 4️⃣ Insert merchant summaries
    for (const id in merchantGroup) {
      const g = merchantGroup[id];
      const paid = g.amount - g.diff;
      await Bulk.create(
        {
          driver_id: null,
          merchant_id: g.merchant_id,
          count: g.count,
          delivered_count: g.delivered_count,
          amount: g.amount,
          diff: g.diff,
          paid,
          report_date: dateParam, // ✅ save report date
        },
        { transaction: t }
      );
    }

    await t.commit();
    return res.status(200).json({
      success: true,
      message: `✅ Daily closing completed successfully for ${startOfDay.toISOString().slice(0, 10)}`,
      driverReports: Object.keys(driverGroup).length,
      merchantReports: Object.keys(merchantGroup).length,
    });
  } catch (error) {
    await t.rollback();
    console.error("❌ dailyClosing error:", error);
    return res.status(500).json({
      success: false,
      message: "Failed to perform daily closing",
      error: error.message,
    });
  }
};


exports.getBulks = async (req, res) => {
  try {
    const { driver_id, merchant_id, start_date, end_date } = req.query;

    // Build query filters
    let where = {};
    if (driver_id) where.driver_id = driver_id;
    if (merchant_id) where.merchant_id = merchant_id;

    if (start_date && end_date) {
      where.createdAt = {
        [Op.between]: [new Date(start_date + 'T00:00:00'), new Date(end_date + 'T23:59:59')],
      };
    }

    const bulks = await Bulk.findAll({
      where,
      order: [['createdAt', 'DESC']],
    });

    if (!bulks.length) {
      return res.json({ success: false, message: 'No bulks found' });
    }

    res.json({ success: true, data: bulks });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

exports.updatePrice = async (req, res) => {
  const id = req.params.id;
  const { price } = req.body;

  if (price === undefined) {
    return res.status(400).json({ success: false, message: 'Price is required' });
  }

  try {
    const delivery = await Delivery.findByPk(id);
    if (!delivery) {
      return res.status(404).json({ success: false, message: 'Delivery not found' });
    }

    await delivery.update({ price });
    res.json({ success: true, data: delivery });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.updateComment = async (req, res) => {
  try {
    const { id } = req.params;
    const { comment } = req.body;

    if (comment === undefined) {
      return res.status(400).json({ success: false, message: "Comment is required" });
    }

    const [updated] = await Delivery.update(
      { comment },
      { where: { id } }
    );

    if (updated) {
      return res.json({ success: true, message: "Comment updated successfully" });
    } else {
      return res.status(404).json({ success: false, message: "Delivery not found" });
    }
  } catch (error) {
    console.error("Error updating comment:", error);
    res.status(500).json({ success: false, message: "Server error" });
  }
};


exports.updateDeliveryPrice = async (req, res) => {
  const id = req.params.id;
  const { delivery_price } = req.body;

  if (delivery_price === undefined) {
    return res.status(400).json({ success: false, message: 'Price is required' });
  }

  try {
    const delivery = await Delivery.findByPk(id);
    if (!delivery) {
      return res.status(404).json({ success: false, message: 'Delivery not found' });
    }

    await delivery.update({ delivery_price });
    res.json({ success: true, data: delivery });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

// Create and Save a new Categories
exports.create = async (req, res) => {
  if (
    !req.body.merchant_id ||
    !req.body.phone ||
    !req.body.address
  ) {
    return res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  const t = await db.sequelize.transaction();

  try {
    const price = req.body.price ? Number(req.body.price) : 0;
    const comment = req.body.comment || '';

    // Get current time in Ulaanbaatar timezone (REAL createdAt equivalent)
    const UBTime = new Date(
      new Date().toLocaleString('en-US', { timeZone: 'Asia/Ulaanbaatar' })
    );

    const cutOffHour = 12; // 12:00 PM

    // scheduled_date = createdAt day by default
    const scheduledDate = new Date(UBTime);
    scheduledDate.setHours(0, 0, 0, 0);

    // If creation is after 12:00 → schedule next day
    if (UBTime.getHours() >= cutOffHour) {
      scheduledDate.setDate(scheduledDate.getDate() + 1);
    }

    const newDel = {
      merchant_id: req.body.merchant_id,
      phone: req.body.phone,
      address: req.body.address,
      status: 1,
      price,
      comment,
      scheduled_delivery_date: scheduledDate, // <-- EXACT logic implemented
    };

    const delivery = await Delivery.create(newDel, { transaction: t });

    // Insert items if any
    if (req.body.items && Array.isArray(req.body.items)) {
      const itemsToInsert = req.body.items.map(item => ({
        delivery_id: delivery.id,
        good_id: item.good_id,
        quantity: item.quantity || 1,
      }));

      await DeliveryItem.bulkCreate(itemsToInsert, { transaction: t });

      // Reduce stock
      for (const item of req.body.items) {
        const quantity = item.quantity || 1;
        await db.goods.increment(
          { stock: -quantity },
          {
            where: { id: item.good_id },
            transaction: t,
          }
        );
      }
    }

    await t.commit();

    res.json({
      success: true,
      data: delivery,
      scheduled_for: scheduledDate.toISOString().split('T')[0],
      message: `Delivery scheduled for ${scheduledDate.toISOString().split('T')[0]}`
    });

  } catch (err) {
    await t.rollback();
    console.error(err);
    res.status(500).json({
      success: false,
      message: err.message || "Some error occurred while creating the Delivery.",
    });
  }
};

exports.deleteMultiple = async (req, res) => {
  const { ids } = req.body;
  try {
    await Delivery.update(
      { is_deleted: true },
      { where: { id: ids } }
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};


exports.getItemsByDeliveryId = async (req, res) => {
  const deliveryId = req.params.deliveryId;

  if (!deliveryId) {
    return res.status(400).json({ success: false, message: "Delivery ID is required" });
  }

  try {
    const items = await db.delivery_items.findAll({
      where: { delivery_id: deliveryId },
      include: [
        {
          model: db.goods,
          as: 'good',            // matches alias in belongsTo association
          attributes: ['name', ],  // choose fields you want
        }
      ],
    });
    

    res.json({ success: true, data: items });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      success: false,
      message: err.message || "Error fetching delivery items",
    });
  }
};


exports.status = async (req, res) => {
  const { status_id, delivery_ids } = req.body;

  if (!status_id || !Array.isArray(delivery_ids) || delivery_ids.length === 0) {
    return res.status(400).json({
      success: false,
      message: "Status ID and a list of delivery IDs are required.",
    });
  }

  try {
    // Prepare update data
    const updateData = {
      status: status_id,
    };

    // Set report_stage for all statuses except 1
    if (status_id !== 1) {
      updateData.report_stage = 1;
    }

    // If status is 3, also update delivered_at
    if (status_id === 3) {
      updateData.delivered_at = new Date();
    }

    // Bulk update deliveries
    await Delivery.update(updateData, {
      where: {
        id: delivery_ids,
      },
    });

    res.json({
      success: true,
      message: "Deliveries updated successfully.",
    });
  } catch (error) {
    console.error("Error updating deliveries:", error);
    res.status(500).json({
      success: false,
      message: "Server error while updating deliveries.",
    });
  }
};


exports.importExcelDeliveries = async (req, res) => {
    const { deliveries } = req.body;
  
    try {
      const results = [];
  
      for (const item of deliveries) {
        const merchant = await User.findOne({ where: { username: item.merchantName } });
        if (!merchant) continue;
  
        const newDelivery = await Delivery.create({
          merchant_id: merchant.id,
          phone: item.phone,
          address: item.address,
          price: parseFloat(item.price),
          comment: item.comment,
          status: 1, // Default status (e.g. "шинэ")
          
        });
  
        results.push(newDelivery);
      }
  
      res.status(200).json({ success: true, inserted: results.length });
    } catch (err) {
      console.error('Import error:', err);
      res.status(500).json({ success: false, message: 'Failed to import deliveries.' });
    }
  };

  //80989497

 exports.allocateDeliveries = async (req, res) => {
    const { driver_id, delivery_ids, delivery_date } = req.body;
  
    if (!driver_id || !Array.isArray(delivery_ids) || delivery_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: "Driver ID and a list of delivery IDs are required.",
      });
    }
  
    try {
      // Use the provided delivery date or default to today
      const newCreatedAt = delivery_date ? new Date(delivery_date) : new Date();
      
      // Bulk update the deliveries
      await Delivery.update(
        {
          driver_id,     // Assign the driver ID
          status: 2,     // Set the status to 2 (or any value that represents the allocated state)
          createdAt: newCreatedAt, // Update the creation date
        },
        {
          where: {
            id: delivery_ids, // Filter by the selected delivery IDs
          },
        }
      );
  
      res.json({
        success: true,
        message: "Deliveries allocated and status updated successfully.",
        data: {
          allocated_count: delivery_ids.length,
          delivery_date: newCreatedAt
        }
      });
    } catch (error) {
      console.error("Error allocating deliveries:", error);
      res.status(500).json({
        success: false,
        message: "Server error while allocating deliveries.",
      });
    }
  };
  
// Retrieve all Categories from the database.
exports.findAll = async (req, res) => {
  try {
    // Pagination
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;

    // Query params
    const { merchant_id, status_ids, driver_id, phone, start_date, end_date } = req.query;
    const statusIds = status_ids ? status_ids.split(',').map(Number) : [];

    // Base WHERE
    const where = {
      [Op.or]: [{ is_deleted: false }, { is_deleted: null }],
    };

    if (merchant_id) where.merchant_id = merchant_id;
    if (driver_id) where.driver_id = driver_id;
    if (phone) where.phone = { [Op.like]: `%${phone}%` };
    if (statusIds.length > 0) where.status = { [Op.in]: statusIds };

    // --- Date Filtering (scheduled_delivery_date) ---
    let filterStart, filterEnd;

    if (start_date && end_date) {
      // Range selected → filter by scheduled_delivery_date
      filterStart = new Date(start_date);
      filterStart.setHours(0, 0, 0, 0);

      filterEnd = new Date(end_date);
      filterEnd.setHours(23, 59, 59, 999);
    } else {
      // No range → default = today (UB timezone)
      const UBTime = new Date(
        new Date().toLocaleString('en-US', { timeZone: 'Asia/Ulaanbaatar' })
      );

      filterStart = new Date(UBTime);
      filterStart.setHours(0, 0, 0, 0);

      filterEnd = new Date(UBTime);
      filterEnd.setHours(23, 59, 59, 999);
    }

    where.scheduled_delivery_date = { [Op.between]: [filterStart, filterEnd] };

    // Query
    const { count, rows } = await Delivery.findAndCountAll({
      where,
      limit,
      offset,
      include: [
        { model: User, as: 'merchant', attributes: ['username'] },
        { model: Status, as: 'status_name', attributes: ['status', 'color'] },
        { model: User, as: 'driver', attributes: ['username'] },
      ],
      order: [['id', 'DESC']],
    });

    res.status(200).json({
      success: true,
      data: rows.map(d => d.toJSON()),
      pagination: { total: count, page, limit },
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};


  exports.findAllWithDate = async (req, res) => {
    try {
      const page = parseInt(req.query.page) || 1;
      const limit = parseInt(req.query.limit) || 10;
      const offset = (page - 1) * limit;
  
      const { startDate, endDate, driverId } = req.query;
  
      const where = {};
  
      // Date range (inclusive)
      if (startDate && endDate) {
        where.createdAt = {
          [Op.gte]: new Date(startDate + 'T00:00:00'),
          [Op.lte]: new Date(endDate + 'T23:59:59'),
        };
      }
  
      // Exclude statuses 1 and 2
      where.status = {
        [Op.notIn]: [1, 2],
      };
      
      where.is_reported = false;
      // Filter by driverId if provided
      if (driverId) {
        where.driver_id = driverId;
      }
  
      const { count, rows } = await Delivery.findAndCountAll({
        where,
        limit,
        offset,
        include: [
          {
            model: User,
            as: 'merchant',
            attributes: ['username'],
          },
          {
            model: Status,
            as: 'status_name',
            attributes: ['status', 'color'],
          },
          {
            model: User,
            as: 'driver',
            attributes: ['username'],
          },
        ],
        order: [['id', 'DESC']],
      });
  
      const formattedDeliveries = rows.map((delivery) => delivery.toJSON());
  
      res.status(200).json({
        success: true,
        data: formattedDeliveries,
        pagination: {
          total: count,
          page,
          limit,
        },
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ success: false, message: 'Server error' });
    }
  };

exports.statistic = async (req, res) => {
  try {
    const merchantId = req.query.merchant_id;

    const now = new Date();
    const todayStart = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), 0, 0, 0));
    const todayEnd = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), 23, 59, 59, 999));
    

    // Define base where condition
     const dateCondition = {
      createdAt: { [Op.between]: [todayStart, todayEnd] },
    };
    // Add merchant_id if exists
    const whereDelivery = merchantId ? { merchant_id: merchantId, ...dateCondition } : dateCondition;
    const whereSuccess = merchantId
      ? { merchant_id: merchantId, status: 3, ...dateCondition }
      : { status: 3, ...dateCondition };
    const whereOrder = merchantId ? { merchant_id: merchantId, ...dateCondition } : dateCondition;
    const whereGood = merchantId ? { merchant_id: merchantId, ...dateCondition } : dateCondition;

    const [deliveryCount, successCount, orderCount, goodsCount] = await Promise.all([
      Delivery.count({ where: whereDelivery }),
      Delivery.count({ where: whereSuccess }),
      Order.count({ where: whereOrder }),
      Good.count({ where: whereGood }),
    ]);

    const successRate =
      deliveryCount > 0 ? parseFloat(((successCount / deliveryCount) * 100).toFixed(2)) : 0;

    res.json({
      success: true,
      deliveries_today: deliveryCount,
      successful_deliveries: successCount,
      success_rate_percent: successRate,
      orders_today: orderCount,
      goods_today: goodsCount,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      success: false,
      message: 'Failed to get statistics',
      error: err.message,
    });
  }
};
  
exports.cancelOrder = (req, res) => {
  const orderId = req.params.id;

  Delivery.update({ status: 5 }, { where: { id: orderId } })
    .then(result => {
      if (result[0] === 1) {
        // Fetch the updated delivery record
        return Delivery.findOne({ where: { id: orderId } });
      } else {
        return res.status(404).json({
          success: false,
          message: `Order not found or already cancelled: id=${orderId}`
        });
      }
    })
    .then(data => {
      if (data) {
        let result = data.toJSON();
        result.status = 'цуцалсан'; // translate status to text
        res.json({
          success: true,
          message: "Order was cancelled successfully.",
          data: result
        });
      }
    })
    .catch(err => {
      console.error("Error cancelling order:", err);
      res.status(500).json({
        success: false,
        message: `Error cancelling order with id=${orderId}`,
        error: err.message
      });
    });
};


// Find a single Categories with an id
exports.findOne = async (req, res) => {
  const id = req.params.id;
  
  try {
    const delivery = await Delivery.findOne({
      where: { id },
      include: [
        {
          model: User,
          as: 'merchant',     // alias in model associations
          attributes: ['id', 'username'] // select only what you need
        },
        {
          model: Status,
          as: 'status_name',   // alias for status table
          attributes: ['id', 'status']
        }
      ]
    });

    if (delivery) {
      res.json({
        success: true,
        data: delivery
      });
    } else {
      res.status(404).json({ success: false, message: 'Delivery not found' });
    }
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Update a Categories by the id in the request
exports.update = (req, res) => {
  const id = req.params.id;

  // Validate request (ensure at least one field is provided)
  if (!req.body.phone && !req.body.address && req.body.price === undefined) {
    return res.status(400).json({
      success: false,
      message: "Request body cannot be empty. At least phone, address, or price is required.",
    });
  }

  // Prepare the data for updating
  const updateData = {};
  
  // Only include fields that are provided in the request
  if (req.body.phone !== undefined) updateData.phone = req.body.phone;
  if (req.body.address !== undefined) updateData.address = req.body.address;
  if (req.body.price !== undefined) updateData.price = req.body.price;

  // Update the delivery entry in the database
  Delivery.update(updateData, { where: { id: id } })
    .then((num) => {
      if (num[0] === 1) {
        return Delivery.findByPk(id); // Fetch the updated delivery
      } else {
        throw new Error("Delivery not found or no changes were made.");
      }
    })
    .then((updatedDelivery) => {
      res.json({
        success: true,
        message: "Delivery was updated successfully.",
        data: updatedDelivery,
      });
    })
    .catch((err) => {
      res.status(500).json({
        success: false,
        message: "Error updating delivery with id=" + id,
        error: err.message,
      });
    });
};

exports.infoupdate = (req, res) => {
  const id = req.params.id;

  // Validate request (ensure at least one field is provided)
  if (
    !req.body.lookfor &&
    !req.body.area &&
    !req.body.size &&
    !req.body.request
  ) {
    return res.status(400).json({
      success: false,
      message: "Request body cannot be empty. At least one field is required.",
    });
  }

  // Prepare the data for updating
  const updateData = {
 
    lookfor: req.body.lookfor || null,
    area: req.body.area || null,
    size: req.body.size || null,
    request: req.body.request || null,
  };
    console.log(updateData);
  // Update the category entry in the database
  category.update(updateData, { where: { id: id } })
    .then((num) => {
      if (num[0] === 1) {
        return category.findByPk(id); // Fetch the updated category
      } else {
        throw new Error("Category not found or no changes were made.");
      }
    })
    .then((updatedCategory) => {
      res.json({
        success: true,
        message: "Category was updated successfully.",
        data: updatedCategory,
      });
    })
    .catch((err) => {
      res.status(500).json({
        success: false,
        message: "Error updating category with id=" + id,
        error: err.message,
      });
    });
};


// Delete a category with the specified id in the request
exports.delete = (req, res) => {
  const id = req.params.id;

  category.destroy({
    where: { id: id }
  })
    .then(num => {
      if (num == 1) {
        res.json({ success: true, message: "Category was deleted successfully!" });

      } else {
        res.send({
          message: `Cannot delete Categories with id=${id}. Maybe category was not found!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Could not delete category with id=" + id
      });
    });
};

// Delete all Tutorials from the database.
exports.deleteAll = (req, res) => {
  category.destroy({
    where: {},
    truncate: false
  })
    .then(nums => {
      res.send({ message: `${nums} category were deleted successfully!` });
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while removing all category."
      });
    });
};

// find all published Categories
exports.findAllPublished = (req, res) => {
  category.findAll({ where: { published: true } })
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving category."
      });
    });
};
