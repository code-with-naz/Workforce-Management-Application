const express = require('express');
const router = express.Router();
const Attendance = require('../model/attendanceemp');
const mongoose = require('mongoose'); // Import mongoose

// Route to update attendance
router.post('/update', async (req, res) => {
    const { employeeId, date, status } = req.body;

    if (!employeeId || !date || !status) {
        return res.status(400).json({ message: 'Missing required fields' });
    }

    try {
        const parsedDate = new Date(date);
        if (isNaN(parsedDate.getTime())) {
            return res.status(400).json({ message: "Invalid date format" });
        }

        // Convert employeeId to ObjectId
        
        const objectId = new mongoose.Types.ObjectId(employeeId);

       
        // Find or create attendance record
        let attendance = await Attendance.findOne({ employeeId: objectId });

        if (!attendance) {
            attendance = new Attendance({ employeeId: objectId, attendance: {} });
        }

        // Update attendance for the selected date
        attendance.attendance.set(parsedDate.toISOString().split('T')[0], status); // Use ISO string for date key

        await attendance.save();
        res.json({ message: 'Attendance updated successfully', attendance });
    } catch (err) {
        console.error('Error updating attendance:', err);
        res.status(500).json({ message: 'Internal server error', error: err.message });
    }
});



module.exports = router;
