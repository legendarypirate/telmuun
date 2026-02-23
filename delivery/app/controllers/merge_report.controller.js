const db = require("../models");
const Delivery = db.deliveries;
const Op = db.Sequelize.Op;
const Summary = db.summaries; // Add this
const Status = db.statuses; // Add this
const User = db.users; // Add this

const dayjs = require("dayjs");
const utc = require("dayjs/plugin/utc");
const timezone = require("dayjs/plugin/timezone");

dayjs.extend(utc);
dayjs.extend(timezone);
const { sequelize } = require('../models'); // adjust path if needed

exports.driver = async (req, res) => {
  const t = await sequelize.transaction(); // Start transaction

  try {
    const { driverId, startDate, endDate } = req.query;

    const where = {
      status: { [Op.ne]: 1 },   // 🚨 Exclude status 1
      report_stage: 1,
      driver_id: { [Op.not]: null }, // ✅ Only deliveries with a driver assigned
    };

    // ✅ Filter by specific driver if provided
    if (driverId) {
      where.driver_id = driverId;
    }

    // ✅ Date range filter
    if (startDate && endDate) {
      where.delivered_at = {
        [Op.between]: [new Date(startDate), new Date(endDate)],
      };
    }

    const deliveries = await Delivery.findAll({
      where,
      include: [
        {
          model: User,
          as: "merchant",
          attributes: ["username"],
        },
        {
          model: Status,
          as: "status_name",
          attributes: ["status", "color"],
        },
        {
          model: User,
          as: "driver",
          attributes: ["username"],
        },
      ],
      order: [["id", "DESC"]],
      transaction: t,
    });

    await t.commit();
    return res.status(200).json({
      success: true,
      data: deliveries,
      message:
        deliveries.length === 0
          ? "No deliveries found for given filters."
          : undefined,
    });
  } catch (error) {
    await t.rollback();
    console.error("Error fetching deliveries:", error);
    return res.status(500).json({
      success: false,
      message: "Server error",
    });
  }
};


exports.merge_driver = async (req, res) => {
  const t = await sequelize.transaction(); // Start transaction

  try {
    const { driverId, startDate, endDate } = req.query;

    const where = {
      status: { [Op.in]: [3, 4, 5] },
      report_stage: 2,
    };

    // ✅ driver filter (if provided)
    if (driverId) {
      where.driver_id = driverId;
    }

    // ✅ date filter (if both provided)
    if (startDate && endDate) {
      where.delivered_at = {
        [Op.between]: [new Date(startDate), new Date(endDate)],
      };
    }

    const deliveries = await Delivery.findAll({
      where,
      include: [
        {
          model: User,
          as: "merchant",
          attributes: ["username"], // ✅ merchant name
        },
        {
          model: Status,
          as: "status_name",
          attributes: ["status", "color"], // ✅ status info
        },
        {
          model: User,
          as: "driver",
          attributes: ["username"], // ✅ driver name
        },
      ],
      order: [["id", "DESC"]],
      transaction: t,
    });

    if (!deliveries || deliveries.length === 0) {
      await t.commit(); // no error, commit transaction
      return res.status(200).json({
        success: true,
        data: [],   // ✅ return empty array instead of error
        message: "No deliveries found for given filters."
      });
    }
    
    await t.commit();
    return res.status(200).json({
      success: true,
      data: deliveries,
    });
  } catch (error) {
    await t.rollback();
    console.error("Error fetching deliveries:", error);
    return res.status(500).json({
      success: false,
      message: "Server error",
    });
  }
};


exports.merge_merchant = async (req, res) => {
  const t = await sequelize.transaction(); // Start transaction

  try {
    const { merchantId, startDate, endDate } = req.query;

    const where = {
      status: { [Op.in]: [3, 4, 5] },
      report_stage: 3,
    };

    // ✅ driver filter (if provided)
    if (merchantId) {
      where.merchant_id = merchantId;
    }

    // ✅ date filter (if both provided)
    if (startDate && endDate) {
      where.delivered_at = {
        [Op.between]: [new Date(startDate), new Date(endDate)],
      };
    }

    const deliveries = await Delivery.findAll({
      where,
      include: [
        {
          model: User,
          as: "merchant",
          attributes: ["username"], // ✅ merchant name
        },
        {
          model: Status,
          as: "status_name",
          attributes: ["status", "color"], // ✅ status info
        },
        {
          model: User,
          as: "driver",
          attributes: ["username"], // ✅ driver name
        },
      ],
      order: [["id", "DESC"]],
      transaction: t,
    });

    if (!deliveries || deliveries.length === 0) {
      await t.commit(); // no error, commit transaction
      return res.status(200).json({
        success: true,
        data: [],   // ✅ return empty array instead of error
        message: "No deliveries found for given filters."
      });
    }
    
    await t.commit();
    return res.status(200).json({
      success: true,
      data: deliveries,
    });
  } catch (error) {
    await t.rollback();
    console.error("Error fetching deliveries:", error);
    return res.status(500).json({
      success: false,
      message: "Server error",
    });
  }
};

exports.merchant = async (req, res) => {
  const t = await sequelize.transaction(); // Start transaction

  try {
    const { merchantId, startDate, endDate } = req.query;

    const where = {
      status: { [Op.in]: [3, 4, 5] },
      report_stage: 2,
    };

    // ✅ driver filter (if provided)
    if (merchantId) {
      where.merchant_id = merchantId;
    }

    // ✅ date filter (if both provided)
    if (startDate && endDate) {
      where.delivered_at = {
        [Op.between]: [new Date(startDate), new Date(endDate)],
      };
    }

    const deliveries = await Delivery.findAll({
      where,
      include: [
        {
          model: User,
          as: "merchant",
          attributes: ["username"], // ✅ merchant name
        },
        {
          model: Status,
          as: "status_name",
          attributes: ["status", "color"], // ✅ status info
        },
        {
          model: User,
          as: "driver",
          attributes: ["username"], // ✅ driver name
        },
      ],
      order: [["id", "DESC"]],
      transaction: t,
    });

    if (!deliveries || deliveries.length === 0) {
      await t.commit(); // no error, commit transaction
      return res.status(200).json({
        success: true,
        data: [],   // ✅ return empty array instead of error
        message: "No deliveries found for given filters."
      });
    }
    
    await t.commit();
    return res.status(200).json({
      success: true,
      data: deliveries,
    });
  } catch (error) {
    await t.rollback();
    console.error("Error fetching deliveries:", error);
    return res.status(500).json({
      success: false,
      message: "Server error",
    });
  }
};
// Retrieve all Categories from the database.
exports.findAll = async (req, res) => {
  const name = req.query.name;
  var condition = name ? { name: { [Op.like]: `%${name}%` } } : null;

  try {
      console.log("ss");    
    const data = await category.findAll({ where: condition });
    console.log(data);

    res.send({
      success: true,
      data: data
    });
  } catch (err) {
    res.status(500).send({
      success: false,
      message: err.message || "Some error occurred while retrieving Categories."
    });
  }
};

exports.findDeliveriesByReportId = async (req, res) => {
  const { id } = req.params;

  try {
    const deliveries = await Delivery.findAll({
      where: { report_id: id },
      include: [
        {
          model: User,
          as: 'merchant',
          attributes: ['username'],
        },
        {
          model: Status,
          as: 'status_name',
          attributes: ['status', 'color'], // make sure status has these fields
        }
      ],
      attributes: ['id', 'merchant_id', 'phone', 'address', 'driver_id', 'price', 'status', 'createdAt'],
    });

    res.json({
      success: true,
      data: deliveries,
    });
  } catch (error) {
    console.error('Error fetching deliveries by report ID:', error);
    res.status(500).json({
      success: false,
      message: "Failed to fetch deliveries for the given report ID.",
    });
  }
};

// Find a single Categories with an id
exports.findOne = (req, res) => {
  const id = req.params.id;

  category.findByPk(id)
    .then(data => {
      if (data) {
        res.send(data);
      } else {
        res.status(404).send({
          message: `Cannot find category with id=${id}.`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving category with id=" + id
      });
    });
};

// Update a Categories by the id in the request
exports.update = (req, res) => {
  const id = req.params.id;

  // Validate request (ensure at least one field is provided)
  if (!req.body.brand && !req.body.nature) {
    return res.status(400).json({
      success: false,
      message: "Request body cannot be empty. At least brand or nature is required.",
    });
  }

  // Prepare the data for updating
  const updateData = {
    brand: req.body.brand || null,
    nature: req.body.nature || null,
  };

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
