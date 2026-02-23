module.exports = (sequelize, Sequelize) => {
  const Bulk = sequelize.define("bulk", {
    driver_id: {
      type: Sequelize.INTEGER,
      allowNull: true,
    },
    merchant_id: {
      type: Sequelize.INTEGER,
      defaultValue: 0,
    },
    count: {
      type: Sequelize.INTEGER,
      defaultValue: 0,
    },
    delivered_count: { // ✅ new field
      type: Sequelize.INTEGER,
      defaultValue: 0,
    },
    amount: {
      type: Sequelize.DECIMAL(10, 2),
      allowNull: false,
      defaultValue: 0,
    },
    diff: {
      type: Sequelize.DECIMAL(10, 2),
      allowNull: false,
      defaultValue: 0,
    },
    paid: {
      type: Sequelize.DECIMAL(10, 2),
      allowNull: false,
      defaultValue: 0,
    },
    report_date: { // ✅ added field
      type: Sequelize.DATE,
      allowNull: false,
    },
  });

  return Bulk;
};
