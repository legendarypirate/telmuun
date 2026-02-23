const multer = require('multer');

// Configure multer for memory storage
const storage = multer.memoryStorage();
const upload = multer({ 
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB limit
  }
});

module.exports = app => {
    const delivery = require("../controllers/delivery.mobile.controller.js");
    var router = require("express").Router();
    
    router.get("/report", delivery.report);
    router.get("/merchant", delivery.findMerchantDelivery);
    router.get('/:driver_id/status-counts', delivery.getStatusCountsByDriver);

    // Get deliveries for a driver (mobile)
    router.get("/my", delivery.findUserDeliveries);

    // Mark delivery as complete WITH IMAGE UPLOAD
    router.post("/complete/:id", upload.single('image'), delivery.completeDelivery);
    
    router.get("/driver/:id/status-2", delivery.findDriverDeliveriesWithStatus);
    router.get("/:deliveryId", delivery.findByDeliverId);
    router.get("/driver/:id/status-3", delivery.findDeliveryDone);
    router.post("/comment/:id", delivery.addDriverComment);

    app.use('/api/mobile/delivery', router);
};