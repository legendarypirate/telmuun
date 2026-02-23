const db = require("../models");
const User = db.users;
const Op = db.Sequelize.Op;
const bcrypt = require("bcryptjs"); // Using bcryptjs for hashing and comparing passwords
const jwt = require("jsonwebtoken");
const secretKey = 'your_secret_key';  // You can store this key in .env for better security
const Joi = require('joi');
const Delivery = db.deliveries;
const { IncomingForm } = require('formidable');

// Create and Save a new Banner
exports.login = async (req, res) => {
  const form = new IncomingForm();

  form.parse(req, async (err, fields) => {
    if (err) {
      console.error("Form parsing error:", err);
      return res.status(400).json({ message: "Invalid form data" });
    }

    const { name, password } = fields;

    if (!name || !password) {
      return res.status(400).json({ message: "Username and password are required!" });
    }

    try {
      const user = await User.findOne({ where: { name } });
      if (!user) {
        return res.status(401).json({ message: "Invalid credentials!" });
      }

      const passwordMatch = await bcrypt.compare(String(password), user.password);
      if (!passwordMatch) {
        return res.status(401).json({ message: "Invalid credentials!" });
      }

     const token = jwt.sign(
        { id: user.id, name: user.name, role: user.role_id },
        secretKey
        // no expiresIn — token will not expire
      );


      return res.json({
        success: true,
        token: {
          access_token: token
        },
        user: {
          id: user.id,
          name: user.name,
          role: user.role_id,
        },
      });
    } catch (err) {
      console.error("Login error:", err);
      res.status(500).json({ message: "Internal server error" });
    }
  });
};


// Retrieve all Banners from the database.
exports.create_order = async (req, res) => {
  // Input validation
  const schema = Joi.object({
  sender: Joi.object({
    fname: Joi.string().required(),
    phone1: Joi.string().required(),
    zipcode: Joi.string().required(),
    gps: Joi.object({
      lat: Joi.string().required(),
      lng: Joi.string().required()
    }).required(),
    address: Joi.object({
      detail: Joi.string().required()
    }).unknown(true) // allow extra keys like apartmentCode
  }).unknown(true),

  receiver: Joi.object({
    phone1: Joi.string().required(),
    zipcode: Joi.string().required(),
    address: Joi.object({
      detail: Joi.string().required()
    }).unknown(true) // allow apartmentCode or other fields
  }).unknown(true),

  customerName: Joi.string().required(),

  lineItemList: Joi.array().items(
    Joi.object({
      name: Joi.string().required(),
      weightTypeNo: Joi.number().integer().required(),
      warningValue: Joi.string().required(),
      deliveryCost: Joi.number().required()
    }).unknown(true) // if line item objects might have more fields
  ).required()
}).unknown(true);


  const { error, value } = schema.validate(req.body);
  if (error) {
    return res.status(422).json({ errors: error.details });
  }

  const {
    sender,
    receiver,
    lineItemList
  } = value;

  // Helper to get zipcode name
  const getZipcodeName = async (zipcode) => {
    try {
      const response = await axios.get(`https://www.mydelivery.mn/api/common/zipcode/childList?zipcode=${zipcode}`);
      return response.data?.result?.zipcode?.nameMn || zipcode;
    } catch (err) {
      return zipcode; // fallback to raw zipcode
    }
  };

  try {
    const senderZipcodeName = await getZipcodeName(sender.zipcode);
    const receiverZipcodeName = await getZipcodeName(receiver.zipcode);

    // Save main delivery record
    const delivery = await Delivery.create({
      shop: 'hibox',
      sender_phone: sender.phone1,
      zipcode: senderZipcodeName,
      merchant_id: 2,
      lat: sender.gps.lat,
      lng: sender.gps.lng,
      receiver_address: sender.address.detail, // ← this is like PHP: $request->input('sender.address.detail')
      phone: receiver.phone1,
      address: receiver.address.detail,
      receiver_zipcode: receiverZipcodeName,
      status: 1
    });

    let totalPrice = 0;

    for (const item of lineItemList) {
    //   await Delorder.create({
    //     reqid: delivery.id,
    //     name: item.name,
    //     weight_type_no: item.weightTypeNo,
    //     warning_value: item.warningValue,
    //     delivery_cost: item.deliveryCost
    //   });

      // Calculate price by weightTypeNo
      switch (item.weightTypeNo) {
        case 1:
          totalPrice += 6500;
          break;
        case 2:
        case 3:
          totalPrice += 12100;
          break;
        case 4:
          totalPrice += 17600;
          break;
        default:
          totalPrice += 0;
      }
    }

    // Update delivery price
    delivery.price = totalPrice;
    await delivery.save();

    return res.json({ data: delivery, success: true });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: 'Internal server error' });
  }
}

// Find a single Banner with an id
exports.findOne = (req, res) => {
  const id = req.params.id;

  Age.findByPk(id)
    .then(data => {
      if (data) {
        res.json({ success: true, data: data });
      } else {
        res.status(404).json({ success: false, message: `Cannot find Banner with id=${id}.` });
      }
    })
    .catch(err => {
      res.status(500).json({ success: false, message: "Error retrieving Banner with id=" + id });
    });
};

const statusMap = {
  1: "Шинэ",
  2: "Жолоочид",
  3: "Хүргэсэн",
  4: "Буцаасан",
  5: "Цуцалсан"
};

exports.checkOrder = (req, res) => {
  const orderId = req.params.id;

  Delivery.findOne({
    where: { id: orderId },
    order: [['createdAt', 'DESC']]
  })
    .then(data => {
      if (data) {
        // Clone data to plain object for modification
        let result = data.toJSON();

        // Translate status
        if (result.status === 1) {
          result.status = 'new';
        } else if (result.status === 2) {
          result.status = 'driver';
        } else if (result.status === 3) {
          result.status = 'delivered';
        }

        res.json({ data: result, success: true });
      } else {
        res.status(404).json({ success: false, message: `Order not found: id=${orderId}` });
      }
    })
    .catch(err => {
      console.error("Error retrieving order:", err);
      res.status(500).json({ success: false, message: `Error retrieving order with id=${orderId}` });
    });
};

// Update a Banner by the id in the request
exports.update = (req, res) => {
  const id = req.params.id;
  console.log(req.body);
  const updateData = {
    age: req.body.age || null,// Convert age to JSON if present
  };

  Age.update(updateData, {
    where: { id: id }
  })
    .then(num => {
      if (num == 1) {
        return Age.findByPk(id); // Fetch the updated entry
      } else {
        throw new Error(`Cannot update Banner with id=${id}. Maybe Banner was not found or req.body is empty!`);
      }
    })
    .then(updatedEntry => {
      res.json({
        success: true,
        message: "age was updated successfully.",
        data: updatedEntry
      });
    })
    .catch(err => {
      res.status(500).json({
        success: false,
        message: "Error updating Banner with id=" + id,
        error: err.message
      });
    });
};


// Delete a Banner with the specified id in the request
exports.delete = (req, res) => {
  const id = req.params.id;

  Age.destroy({
    where: { id: id }
  })
    .then(num => {
      if (num == 1) {
        res.json({ success: true, message: "Age was deleted successfully!" });
      } else {
        res.status(404).json({ success: false, message: `Cannot delete Banner with id=${id}. Maybe Banner was not found!` });
      }
    })
    .catch(err => {
      res.status(500).json({ success: false, message: "Could not delete Banner with id=" + id });
    });
};

// Delete all Banners from the database.
exports.deleteAll = (req, res) => {
  Banner.destroy({
    where: {},
    truncate: false
  })
    .then(nums => {
      res.json({ success: true, message: `${nums} Banners were deleted successfully!` });
    })
    .catch(err => {
      res.status(500).json({ success: false, message: err.message || "Some error occurred while removing all banners." });
    });
};

// find all published Banner
exports.findAllPublished = (req, res) => {
    Age.findAll({ where: { published: true } })
    .then(data => {
      res.json({ success: true, data: data });
    })
    .catch(err => {
      res.status(500).json({ success: false, message: err.message || "Some error occurred while retrieving banners." });
    });
};
