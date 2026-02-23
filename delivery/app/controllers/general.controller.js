const db = require("../models");
const General = db.generals;
const Op = db.Sequelize.Op;
const Delivery = db.deliveries;
const User = db.users;

// Create and Save a new Categories
exports.merge_driver = async (req, res) => {
    const { driver_id, delivery_ids, count, sum, status, type } = req.body;
  
    if (!driver_id || !Array.isArray(delivery_ids) || delivery_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: "driver_id and delivery_ids are required",
      });
    }
  
    const t = await db.sequelize.transaction();
  
    try {
      // 1️⃣ Update report_stage of selected deliveries
      await Delivery.update(
        { report_stage: 2 },
        {
          where: { id: delivery_ids },
          transaction: t,
        }
      );
  
      // 2️⃣ Create a new record in generals (driver_id goes into user_id)
      await General.create(
        {
          user_id: driver_id,  // ✅ map driver_id -> user_id
          count,
          sum,
          account: sum, // ✅ set account equal to sum
          status: status || 1,
          type: type || 1,
        },
        { transaction: t }
      );
  
      // 3️⃣ Commit transaction
      await t.commit();
  
      return res.status(200).json({
        success: true,
        message: "Deliveries merged successfully",
      });
    } catch (err) {
      await t.rollback();
      console.error(err);
      return res.status(500).json({
        success: false,
        message: "Server error while merging deliveries",
        error: err.message,
      });
    }
  };


  exports.updateAccount = async (req, res) => {
    const id = req.params.id;
    const { account } = req.body;
  
    try {
      // Find existing record
      const general = await General.findByPk(id);
      if (!general) {
        return res.status(404).json({ success: false, message: "General not found" });
      }
  
      const newAccount = Math.min(parseFloat(account), parseFloat(general.sum));
      const newCash = parseFloat(general.sum) - newAccount;
  
      // Update both account and cash
      await general.update({ account: newAccount, cash: newCash });
  
      res.json({ success: true, data: general });
    } catch (err) {
      console.error(err);
      res.status(500).json({ success: false, message: err.message });
    }
  };

// Retrieve all Categories from the database.
exports.merge_customer = async (req, res) => {
    const { merchant_id, delivery_ids, count, sum, status, type } = req.body;
  
    if (!merchant_id || !Array.isArray(delivery_ids) || delivery_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: "driver_id and delivery_ids are required",
      });
    }
  
    const t = await db.sequelize.transaction();
  
    try {
      // 1️⃣ Update report_stage of selected deliveries
      await Delivery.update(
        { report_stage: 3 },
        {
          where: { id: delivery_ids },
          transaction: t,
        }
      );
  
      // 2️⃣ Create a new record in generals (driver_id goes into user_id)
      await General.create(
        {
          user_id: merchant_id,  // ✅ map driver_id -> user_id
          count,
          sum,
          account: sum, // ✅ set account equal to sum
          status: status || 1,
          type: type || 1,
        },
        { transaction: t }
      );
  
      // 3️⃣ Commit transaction
      await t.commit();
  
      return res.status(200).json({
        success: true,
        message: "Deliveries merged successfully",
      });
    } catch (err) {
      await t.rollback();
      console.error(err);
      return res.status(500).json({
        success: false,
        message: "Server error while merging deliveries",
        error: err.message,
      });
    }
  };


// Find a single Categories with an id
exports.findAll = async (req, res) => {
    const { status, user_id, merchantId, type } = req.query;
  
    // Build condition dynamically
    let condition = {};
    if (status) condition.status = status;
    if (user_id) condition.user_id = user_id;
    if (merchantId) condition.user_id = merchantId; // Map merchantId to user_id
    if (type) condition.type = type;
  
    try {
      const data = await General.findAll({
        where: Object.keys(condition).length ? condition : undefined,
        include: [
          {
            model: db.users,
            as: "user", // must match association alias
            attributes: ["username"], // only fetch username
          },
        ],
        order: [["id", "DESC"]], // ✅ order by id descending
      });
  
      res.json({ success: true, data });
    } catch (err) {
      res.status(500).json({
        success: false,
        message: err.message || "Some error occurred while retrieving generals.",
      });
    }
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

  Region.destroy({
    where: { id: id }
  })
    .then(num => {
      if (num == 1) {
        res.json({ success: true, message: "Region was deleted successfully!" });

      } else {
        res.send({
          message: `Cannot delete Categories with id=${id}. Maybe Region was not found!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Could not delete Region with id=" + id
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
