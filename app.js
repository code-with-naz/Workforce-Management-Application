const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('./config/db'); // Import the database configuration
const userRoutes = require('./routers/userrouter');
const employeeRoutes = require('./routers/employeerouter');
const attendRoutes = require('./routers/attendrouter'); // Import attendance routes
const { getAttendanceByEmployeeId, markAttendance } = require('./controller/attendancecontroller');
const remarkRoutes = require('./routers/remarkrouter');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to parse JSON bodies
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Define routes
app.use('/', userRoutes); // User-related routes
app.use('/api/employee', employeeRoutes); // Employee-related routes
app.use('/api/empattendance', attendRoutes); // Attendance-related routes
app.get('/api/getAttendance', getAttendanceByEmployeeId );
app.post('/api/markAttendance', markAttendance);
app.use('/api',remarkRoutes);


// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ status: false, message: 'Internal server error', error: err.message });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

module.exports = app;
