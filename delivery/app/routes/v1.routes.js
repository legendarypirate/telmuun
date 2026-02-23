module.exports = app => {
    const authMiddleware = require('../middleware/authMiddleware.js');

    const v1 = require("../controllers/v1.controller.js");
  
    var router = require("express").Router();

          router.get("/order/status/:id", v1.checkOrder);
        // router.get("/order/declineOrder/:id", v1.cancelOrder);

    // Create a new ner tomyo
    router.post("/auth/login", v1.login);
  
    // Retrieve all ner tomyo
    router.post("/order_create", authMiddleware, v1.create_order);
  
    // Retrieve all published ner tomyo
    router.get("/published", v1.findAllPublished);
  
    // Retrieve a single ner tomyo with id
    router.get("/:id", v1.findOne);
  
    // Update a ner tomyo with id
    router.put("/:id", v1.update);
  
    // Delete a ner tomyo with id
    router.delete("/:id", v1.delete);
  
    // Delete all ner tomyo
    router.delete("/", v1.deleteAll);
  
    app.use('/api/v1', router);
  };
  