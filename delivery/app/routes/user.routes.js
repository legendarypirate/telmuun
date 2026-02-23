module.exports = app => {
    const user = require("../controllers/user.controller.js");
  
    var router = require("express").Router();
    router.put('/status/:id', user.updateStatus); // <-- NEW ROUTE

    // Create a new Tutorial
    router.post("/", user.create);
    router.get("/merchant", user.findMerchants);
    router.get("/request", user.request); // ✅ NEW ROUTE HERE

    // Retrieve all Tutorials
  
    // Retrieve all published Tutorials
    router.get("/published", user.findAllPublished);
    router.get("/driver", user.findDrivers); // ✅ NEW ROUTE HERE

    // Retrieve a single Tutorial with id
    router.get("/:id", user.findOne);

     router.patch('/:id/password', user.updatePassword);
    // Update a Tutorial with id
    router.put("/:id", user.update);
  
    // Delete a Tutorial with id
    router.delete("/:id", user.delete);
  
    // Delete all Tutorials
    router.delete("/", user.deleteAll);
    router.get("/", user.findAll);

    app.use('/api/user', router);
  };
  