const express = require('express');
const router = express.Router();
const remarkController = require('../controller/remarkcontroller'); // Import the controller

// Routes for employee operations
router.post('/remark', remarkController.addEmployeeremark);
router.get('/', remarkController.getAllEmployeesremark); // Use '/' for fetching all employees instead of '/add'

module.exports = router;
