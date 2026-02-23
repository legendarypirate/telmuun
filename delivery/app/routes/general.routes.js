module.exports = app => {
    const general = require("../controllers/general.controller.js");
  
    var router = require("express").Router();
  
    router.get("/", general.findAll);

    // Create a new Tutorial
    router.post("/merge_driver", general.merge_driver);
  
    // Retrieve all Tutorials
    router.post("/merge_customer", general.merge_customer);
  
    // Retrieve all published Tutorials
    router.patch("/update_account/:id", general.updateAccount);

    // Update a Tutorial with id
    router.patch("/:id", general.update);
  
    // Delete a Tutorial with id
    router.delete("/:id", general.delete);
  
    // Delete all Tutorials
    router.delete("/", general.deleteAll);
  
    app.use('/api/general', router);
  };
  