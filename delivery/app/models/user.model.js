module.exports = (sequelize, Sequelize) => {
    const User = sequelize.define("user", {
      username: {
        type: Sequelize.STRING
      },
      password: {
        type: Sequelize.STRING
      },
      role_id: {
        type: Sequelize.INTEGER
      },
      phone: {
        type: Sequelize.STRING
      },
      address: {
        type: Sequelize.STRING
      },
      firstName: {
        type: Sequelize.STRING
      },
      lastName: {
        type: Sequelize.STRING
      },
      status: {
        type: Sequelize.INTEGER,
        allowNull: false,
        defaultValue: 1,  // optional default
      },      
 address: {
      type: Sequelize.STRING,   // 🏠 New address column
    },
    account_number: {
      type: Sequelize.STRING,   // 💳 New account number column
    },
      registerationNumber: {
        type: Sequelize.STRING
      },
      email: {
        type: Sequelize.STRING
      },
    });
    return User;
  };
  