module.exports = app => {
    const merge_report = require("../controllers/merge_report.controller.js");
  
    var router = require("express").Router();

    // Create a new Tutorial
    router.get("/driver", merge_report.driver);
  
    // Retrieve all Tutorials
    router.get("/merge_driver", merge_report.merge_driver);
  
    // Retrieve all published Tutorials
    router.get("/merchant", merge_report.merchant);
  
    // Retrieve a single Tutorial with id
    router.get("/merge_merchant", merge_report.merge_merchant);
  
      app.use('/api/merge_report', router);
  };
  