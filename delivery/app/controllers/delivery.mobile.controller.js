const db = require("../models");
const Delivery = db.deliveries;
const User = db.users;
const Status = db.statuses;
const Op = db.Sequelize.Op;
const { fn, col, literal } = db.Sequelize;
const DeliveryItem = db.delivery_items;
const Goods=db.goods;
const path = require('path');
const fs = require('fs');
const cloudinary = require('cloudinary').v2; // Make sure cloudinary is configured

exports.findDriverDeliveriesWithStatus = (req, res) => {
  const driverId = req.params.id;

  Delivery.findAll({
    where: {
      driver_id: driverId,
      status: 2
    },
    include: [
      {
        model: User,
        as: 'merchant',
        attributes: ['username'] // only fetch username
      }
    ]
  })
  .then(data => {
    res.send({
      success: true,
      data: data
    });
  })
  .catch(err => {
    res.status(500).send({
      message: err.message || "Some error occurred while retrieving deliveries."
    });
  });
};


exports.addDriverComment = async (req, res) => {
  try {
    const deliveryId = req.params.id;
    const { driver_comment } = req.body;

    if (!driver_comment || driver_comment.trim() === "") {
      return res.status(400).send({ success: false, message: "Тайлбар хоосон байна" });
    }

    // Sequelize update гэж үзэж байна
    const [updated] = await Delivery.update(
      { driver_comment },
      { where: { id: deliveryId } }
    );

    if (updated) {
      res.send({ success: true, message: "Тайлбар хадгалагдлаа" });
    } else {
      res.status(404).send({ success: false, message: "Хүргэлт олдсонгүй" });
    }
  } catch (err) {
    console.error("addDriverComment error:", err);
    res.status(500).send({ success: false, message: "Серверийн алдаа" });
  }
};

exports.findUserDeliveries = (req, res) => {
    const userId = req.query.user_id;
    Delivery.findAll({ where: { driver_id: userId } })
        .then(data => res.send(data))
        .catch(err => res.status(500).send({ message: err.message }));
};


exports.findMerchantDelivery = (req, res) => {
  const userId = req.query.user_id;

  if (!userId) {
    return res.status(400).send({ success: false, message: "Missing user_id" });
  }

  Delivery.findAll({ where: { merchant_id: userId } })
    .then(data => res.send({ success: true, data }))
    .catch(err =>
      res.status(500).send({ success: false, message: err.message })
    );
};

exports.findDeliveryDone = (req, res) => {
  const driverId = req.params.id;
  const { startDate, endDate } = req.query;

  // Build where clause
  const whereClause = {
    driver_id: driverId,
    status: { [Op.in]: [3, 4, 5] }
  };

  // Add date range if both start and end dates are provided
  if (startDate && endDate) {
    whereClause.delivered_at = {
      [Op.between]: [new Date(startDate), new Date(endDate)]
    };
  }

  Delivery.findAll({
    where: whereClause,
    order: [['id', 'DESC']]   // 🔥 Order by id descending
  })
    .then(data => {
      res.send({
        success: true,
        data: data
      });
    })
    .catch(err => {
      res.status(500).send({
        message: err.message || "Some error occurred while retrieving deliveries."
      });
    });
};


exports.findByDeliverId = async (req, res) => {
    const { deliveryId } = req.params;
  
    try {
      const delivery = await Delivery.findOne({
        where: { delivery_id: deliveryId },
        
      });
  
      if (!delivery) {
        return res.status(404).json({ message: "Delivery not found" });
      }
  
      res.json({ success: true, data: delivery });
    } catch (error) {
      console.error("Error fetching delivery by ID:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  };
  exports.getStatusCountsByDriver = async (req, res) => {
    const driverId = req.params.driver_id;
  
    const now = new Date();
    const startOfDay = new Date(now.setHours(0, 0, 0, 0));
    const endOfDay = new Date(now.setHours(23, 59, 59, 999));
  
    try {
      const statuses = await Status.findAll({
        attributes: [
          'id',
          'status',
          'color',
          [
            // Count matching deliveries for this status and driver for today
            literal(`(
              SELECT COUNT(*)
              FROM deliveries AS d
              WHERE d.status = status.id
                AND d.driver_id = ${driverId}
                AND d."createdAt" BETWEEN '${startOfDay.toISOString()}' AND '${endOfDay.toISOString()}'
            )`),
            'count'
          ]
        ],
        order: [['id', 'ASC']]
      });
  
      res.json(statuses);
    } catch (error) {
      console.error("Error fetching full status list with counts:", error);
      res.status(500).json({ error: "Server error", details: error.message });
    }
  };
  exports.report = async (req, res) => {
    const { driver_id, start_date, end_date } = req.query; // or req.body
  
    // Build dynamic WHERE clause
    const whereClause = {};
  
    if (driver_id) {
      whereClause.driver_id = driver_id;
    }
  
    if (start_date && end_date) {
      whereClause.createdAt = {
        [Op.between]: [new Date(start_date), new Date(end_date)],
      };
    } else if (start_date) {
      whereClause.createdAt = {
        [Op.gte]: new Date(start_date),
      };
    } else if (end_date) {
      whereClause.createdAt = {
        [Op.lte]: new Date(end_date),
      };
    }
  
    try {
      const results = await Delivery.findAll({
        where: whereClause,
        attributes: [
          [fn('DATE', col('createdAt')), 'date'],
          [fn('COUNT', col('id')), 'total_deliveries'],
          [fn('SUM', literal('CASE WHEN status = 3 THEN 1 ELSE 0 END')), 'delivered_count'],
          [fn('SUM', literal('CASE WHEN status = 3 THEN price ELSE 0 END')), 'delivered_total_price'],
          [literal('SUM(CASE WHEN status = 3 THEN 1 ELSE 0 END) * 5000'), 'for_driver'],
          [literal('SUM(CASE WHEN status = 3 THEN price ELSE 0 END) - (SUM(CASE WHEN status = 3 THEN 1 ELSE 0 END) * 5000)'), 'driver_margin'],
        ],
        group: [fn('DATE', col('createdAt'))],
        order: [[fn('DATE', col('createdAt')), 'DESC']],
      });
  
      res.json({ success: true, data: results });
    } catch (error) {
      console.error("Error generating delivery report:", error);
      res.status(500).json({ message: "Internal server error" });
    }
  };
  
 exports.completeDelivery = async (req, res) => {
  const id = req.params.id;
  const { status, driver_comment } = req.body;

  if (!status) {
    return res.status(400).send({
      success: false,
      message: "Status is required.",
    });
  }

  const t = await db.sequelize.transaction();

  try {
    const delivery = await Delivery.findByPk(id, { transaction: t });
    if (!delivery) {
      await t.rollback();
      return res.status(404).send({
        success: false,
        message: "Delivery not found.",
      });
    }

    const updateData = {
      status, // This will be whatever frontend sends (3, 4, 10, etc.)
      report_stage: 1,
    };

    // ✅ Completed — record delivery time
    if (parseInt(status, 10) === 3) {
      updateData.delivered_at = new Date();
    }

    // ✅ Add driver comment if provided
    if (driver_comment !== undefined) {
      updateData.driver_comment = driver_comment;
    }

    

    // ✅ Handle image upload directly in this endpoint
    if (req.file) {
      const tempPath = path.join(__dirname, `../../tmp/${Date.now()}.png`);
      const tmpDir = path.dirname(tempPath);
      if (!fs.existsSync(tmpDir)) fs.mkdirSync(tmpDir, { recursive: true });

      fs.writeFileSync(tempPath, req.file.buffer);

      const result = await cloudinary.uploader.upload(tempPath, {
        folder: "deliveries",
        transformation: [
          { width: 1000, crop: "scale" },
          { quality: "auto" },
          { fetch_format: "auto" },
        ],
      });

      fs.unlinkSync(tempPath);
      updateData.image = result.secure_url;
    }

    // ✅ Update delivery record
    await delivery.update(updateData, { transaction: t });

    // ✅ If declined (status 5), restore stock
    if (parseInt(status, 10) === 5) {
      const items = await DeliveryItem.findAll({
        where: { delivery_id: id },
        transaction: t,
      });

      for (const item of items) {
        await Good.increment(
          { stock: item.quantity },
          { where: { id: item.good_id }, transaction: t }
        );
      }
    }

    await t.commit();

    // Format response message
    const tomorrowDate = updateData.scheduled_delivery_date || delivery.scheduled_delivery_date;
    const formattedDate = tomorrowDate ? tomorrowDate.toISOString().split('T')[0] : 'N/A';
    const postponedCount = updateData.postponed_number || delivery.postponed_number || 0;
    
    res.send({
      success: true,
      message:
        parseInt(status, 10) === 10
          ? `Delivery postponed to ${formattedDate}. Status: хойшлуулсан (10). Postponed ${postponedCount} time(s).`
          : "Delivery status updated successfully.",
      data: {
        id,
        status: status, // Return the same status from request
        image: updateData.image || null,
        scheduled_delivery_date: formattedDate,
        postponed_from: delivery.scheduled_delivery_date,
        new_created_at: updateData.createdAt || delivery.createdAt,
        postponed_number: postponedCount,
      },
    });
  } catch (err) {
    await t.rollback();
    console.error("🔥 Delivery completion failed:", err);
    res.status(500).send({
      success: false,
      message: "Server error: " + err.message,
    });
  }
};