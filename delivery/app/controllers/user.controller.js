const db = require("../models");
const User = db.users;
const Op = db.Sequelize.Op;
const bcrypt = require('bcryptjs');
const saltRounds = 10; // Number of salt rounds for bcrypt

// Create and Save a new User
exports.create = async (req, res) => {
  // Validate request
  if (!req.body.username || !req.body.role_id || !req.body.password) {
    res.status(400).send({
      success: false,          // added
      message: "Content can not be empty!"
    });
    return;
  }

  try {
    // Hash the password
    const hashedPassword = await bcrypt.hash(req.body.password, saltRounds);

    // Create a User object
    const user = {
      username: req.body.username,
      phone: req.body.phone,
      email: req.body.email,
      status: 2, // user is pending approval
      address: req.body.address,
      role_id: req.body.role_id,
      password: hashedPassword
    };

    // Save User in the database
    const data = await User.create(user);
    res.send({
      success: true,   // added
      data: data
    });
  } catch (err) {
    res.status(500).send({
      success: false,  // added
      message: err.message || "Some error occurred while creating the User."
    });
  }
};

exports.updatePassword = async (req, res) => {
  const id = req.params.id;
  const { password } = req.body;

  if (!password) {
    return res.status(400).send({ message: "Password is required." });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const num = await User.update(
      { password: hashedPassword },
      { where: { id: id } }
    );

    if (num == 1) {
      res.send({ success: true, message: "Password was updated successfully." });
    } else {
      res.status(404).send({
        success: false,
        message: `Cannot update password for User with id=${id}. User may not exist.`
      });
    }
  } catch (error) {
    console.error(error);
    res.status(500).send({
      success: false,
      message: "Error updating password for User with id=" + id
    });
  }
};  
exports.findMerchants = (req, res) => {
  User.findAll({ where: { role_id: 2 } }) // Adjust the role_id if needed
    .then(data => {
      res.send({ success: true, data });
    })
    .catch(err => {
      res.status(500).send({
        message: err.message || "Some error occurred while retrieving merchants."
      });
    });
};

exports.findDrivers = async (req, res) => {
  try {
    const drivers = await User.findAll({
      where: { 
        role_id: 3,  // driver role
        status: 2    // active or approved status
      },
      attributes: ['id', 'username'] // select only needed fields
    });

    res.send({
      success: true,
      data: drivers
    });
  } catch (err) {
    res.status(500).send({
      success: false,
      message: err.message || "Some error occurred while retrieving drivers."
    });
  }
};


exports.request = async (req, res) => {
  try {
    const request = await User.findAll({
      where: { status: 1 }, // adjust if column name is different
    });

    res.send({
      success: true,
      data: request
    });
  } catch (err) {
    res.status(500).send({
      success: false,
      message: err.message || "Some error occurred while retrieving drivers."
    });
  }
};
exports.findAll = async (req, res) => {
  const username = req.query.username;

  // Build dynamic condition object
  const condition = {
    [Op.and]: [
      { role_id: { [Op.ne]: 1 } },      // Exclude role_id 1
      { status: { [Op.ne]: 1 } }        // Exclude status 1
    ]
  };

  if (username) {
    condition[Op.and].push({
      username: { [Op.like]: `%${username}%` }
    });
  }

  try {
    const data = await User.findAll({ where: condition });

    res.send({
      success: true,
      data: data
    });
  } catch (err) {
    res.status(500).send({
      success: false,
      message: err.message || "Some error occurred while retrieving users."
    });
  }
};

// PUT /api/users/:id/status
exports.updateStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  try {
    const user = await User.findByPk(id);

    if (!user) {
      return res.status(404).json({ success: false, message: 'User not found' });
    }

    user.status = status;
    await user.save();

    res.json({ success: true, message: 'Status updated successfully', user });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Error updating status' });
  }
};


// Find a single User with an id
exports.findOne = (req, res) => {
  const id = req.params.id;

  User.findByPk(id)
    .then(data => {
      if (data) {
        res.send(data);
      } else {
        res.status(404).send({
          message: `Cannot find User with id=${id}.`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving User with id=" + id
      });
    });
};

// Update a User by the id in the request
exports.update = async (req, res) => {
  const id = req.params.id;

  try {
    // Only allow updating these fields
    const { account_number, address, phone, password } = req.body;

    const updateData = {};
    if (account_number !== undefined) updateData.account_number = account_number;
    if (address !== undefined) updateData.address = address;
    if (phone !== undefined) updateData.phone = phone;

    // If password is provided, hash it
    if (password !== undefined) {
      const salt = await bcrypt.genSalt(10);
      updateData.password = await bcrypt.hash(password, salt);
    }

    const [num] = await User.update(updateData, { where: { id } });

    if (num === 1) {
      res.send({ message: "User was updated successfully." });
    } else {
      res.send({
        message: `Cannot update User with id=${id}. Maybe User was not found or no fields were provided!`
      });
    }
  } catch (err) {
    res.status(500).send({
      message: "Error updating User with id=" + id,
      error: err.message
    });
  }
};

// Delete a User with the specified id in the request
exports.delete = async (req, res) => {
  const id = req.params.id;

  try {
    const [num] = await User.update(
      { status: 1 },      // set status to 1 instead of deleting
      { where: { id: id } }
    );

    if (num === 1) {
      res.json({
        success: true,
        message: "User status updated to 1 (soft deleted) successfully!"
      });
    } else {
      res.status(404).json({
        success: false,
        message: `Cannot update User with id=${id}. Maybe User was not found!`
      });
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      message: "Could not update User status with id=" + id
    });
  }
};

// Delete all User from the database.
exports.deleteAll = (req, res) => {
  User.destroy({
    where: {},
    truncate: false
  })
    .then(nums => {
      res.send({ message: `${nums} User were deleted successfully!` });
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while removing all User."
      });
    });
};

// find all published User
exports.findAllPublished = (req, res) => {
  User.findAll({ where: { published: true } })
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving User."
      });
    });
};
