module.exports = (sequelize, Sequelize) => {
  const Delivery = sequelize.define("delivery", {
   merchant_id: {
      type: Sequelize.INTEGER,
      allowNull: false,
    },
    phone: {
      type: Sequelize.STRING,
      allowNull: false,
      defaultValue: "0"
    },
    address: {
      type: Sequelize.STRING,
      allowNull: false,
      defaultValue: "0"
    },
    receiver_address: {
      type: Sequelize.STRING,
      allowNull: true,
      defaultValue: null
    },
    image: {
      type: Sequelize.STRING,
      allowNull: true,
      defaultValue: null
    },
    status: {
      type: Sequelize.INTEGER,
      defaultValue: 0
    },
    is_deleted: {
      type: Sequelize.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    price: {
      type: Sequelize.DECIMAL(10, 2),
      allowNull: false,
      defaultValue: 0
    },
    driver_comment: {
      type: Sequelize.STRING,
      allowNull: true,
      defaultValue: null,
    },
    comment: {
      type: Sequelize.STRING,
      allowNull: false,
      defaultValue: "0"
    },
    driver_id: {
      type: Sequelize.INTEGER,
      allowNull: true,
      defaultValue: null
    },
    is_reported: {
      type: Sequelize.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    report_id: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    delivered_at: {
      type: Sequelize.DATE,
      allowNull: true,
      defaultValue: null,
    },
    delivery_price: {
      type: Sequelize.DECIMAL(10, 2),
      allowNull: false,
      defaultValue: 6000.00
    },
    report_stage: {
      type: Sequelize.INTEGER,
      allowNull: true,
      defaultValue: 0
    },
postponed_number: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
   scheduled_delivery_date: {
      type: Sequelize.DATEONLY,
      allowNull: true, // Changed from false to true
      defaultValue: null // Changed from Sequelize.NOW
    }
  }, {
    // REMOVE the hooks section completely or modify it
    // Only set scheduled_delivery_date when NOT provided
    hooks: {
      beforeCreate: async (delivery) => {
        // Only set if not already provided
        if (!delivery.scheduled_delivery_date) {
          const cutOffHour = 12; // 12:00 PM
          
          // Use Ulaanbaatar timezone for calculation
          const now = new Date();
          const UBTime = new Date(
            now.toLocaleString('en-US', { timeZone: 'Asia/Ulaanbaatar' })
          );
          
          // Calculate scheduled date
          const scheduledDate = new Date(UBTime);
          scheduledDate.setHours(0, 0, 0, 0);
          
          if (UBTime.getHours() >= cutOffHour) {
            scheduledDate.setDate(scheduledDate.getDate() + 1);
          }
          
          delivery.scheduled_delivery_date = scheduledDate;
        }
      }
    }
  });

  return Delivery;
};