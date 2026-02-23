module.exports = (sequelize, Sequelize) => {
    const General = sequelize.define("general", {
      user_id: {
        type: Sequelize.INTEGER,
      },
      type: {
        type: Sequelize.INTEGER,
        defaultValue: 0
      },
      count: {
        type: Sequelize.INTEGER,
        defaultValue: 0
      },
      sum: {
        type: Sequelize.DECIMAL(10, 2),
        allowNull: false,
        defaultValue: 0
      },
      cash: {               // ✅ new column
        type: Sequelize.DECIMAL(10, 2),
        allowNull: false,
        defaultValue: 0
      },
      account: {            // ✅ new column
        type: Sequelize.DECIMAL(10, 2),
        allowNull: false,
        defaultValue: 0
      },
      status: {
        type: Sequelize.INTEGER,
        defaultValue: 0
      },
    });
  
    return General;
  };
  