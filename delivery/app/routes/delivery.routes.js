module.exports = app => {
    const delivery = require("../controllers/delivery.controller.js");
  
  const authMiddleware = require("../middleware/authMiddleware.js"); // ✅ Add this line

    var router = require("express").Router();
 router.put("/bulk/:id/diff", delivery.updateBulkDiff); // ✅ Added PUT route for updating diff

  router.get("/statistic", delivery.statistic);
    router.get('/bulkreport', delivery.getBulks);

    router.post("/upload", delivery.upload);
    router.post("/delete-multiple", delivery.deleteMultiple);

    router.post("/allocate", delivery.allocateDeliveries);
    router.get("/findAllWithDate", delivery.findAllWithDate);

    router.post("/status", delivery.status);
    router.post("/daily-closing", delivery.dailyClosing);

    // Create a new Tutorial
  router.post("/", delivery.create);
  
    // Retrieve all Tutorials
    router.get("/", delivery.findAll);
  
router.patch("/update_price/:id", delivery.updatePrice);
router.patch("/update_comment/:id", delivery.updateComment);

    router.patch("/update_delivery_price/:id", delivery.updateDeliveryPrice);

    // Retrieve all published Tutorials
    router.get("/published", delivery.findAllPublished);
    router.get("/:deliveryId/items", delivery.getItemsByDeliveryId);

    router.put("/bulk/:id", delivery.updateBulkAmount);

    // Retrieve a single Tutorial with id
    router.get("/:id", delivery.findOne);
  
    // Update a Tutorial with id
    router.put("/:id", delivery.update);

    router.post('/import', delivery.importExcelDeliveries);


    // Delete a Tutorial with id
    router.delete("/:id", delivery.delete);
  
    // Delete all Tutorials
    router.delete("/", delivery.deleteAll);
  
    app.use('/api/delivery', router);
  };
  