// userrouter.js
const express = require('express');
const router = express.Router();
const usercontroller = require('../controller/usercontroller'); // Ensure this path is correct


// Define routes
router.post('/registration', usercontroller.register);
router.post('/login', usercontroller.login);


module.exports = router;
