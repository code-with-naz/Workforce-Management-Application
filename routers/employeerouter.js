const express = require('express');
const router = express.Router();
const employeeController = require('../controller/employeecontroller'); // Import the controller

// Routes for employee operations
router.post('/add', employeeController.addEmployee);
router.get('/', employeeController.getAllEmployees); // Use '/' for fetching all employees instead of '/add'

module.exports = router;
