module.exports = (sequelize, Sequelize) => {
  const GoodHistory = sequelize.define("good_history", {
    good_id: {
      type: Sequelize.INTEGER,
      allowNull: false,
    },
    type: {
      type: Sequelize.INTEGER,
      allowNull: false,
    },
    amount: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    delivery_id: {
      type: Sequelize.INTEGER,
      allowNull: true,
    },
    user_id: {
      type: Sequelize.INTEGER,
      allowNull: true,
    },
    comment: {
      type: Sequelize.STRING,
      allowNull: true,
    },
  });

  return GoodHistory;
};
