const mongoose = require('mongoose');
const Attendance = require('../model/attendanceemp');

// Fetch attendance by employee ID
exports.getAttendanceByEmployeeId = async (req, res) => {
    try {
       
        const employeeId = new mongoose.Types.ObjectId(req.params._id); // Ensure employeeId is an ObjectId

        const attendance = await Attendance.findOne({ employeeId });

        if (!attendance) {
            return res.status(404).json({ message: 'No attendance record found' });
        }

        res.json(attendance);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching attendance', error: err.message });
    }
};

// Mark or update attendance for an employee
exports.markAttendance = async (req, res) => {
    try {
        const employeeId = new mongoose.Types.ObjectId(req.params.employeeId); // Ensure employeeId is an ObjectId
        const { date, status } = req.body;

        let attendance = await Attendance.findOne({ employeeId });

        if (!attendance) {
            attendance = new Attendance({ employeeId, attendance: {} });
        }

        // Update attendance for the selected date
        attendance.attendance.set(date, status);

        await attendance.save();
        res.json({ message: 'Attendance updated successfully', attendance });
    } catch (err) {
        res.status(500).json({ message: 'Error updating attendance', error: err.message });
    }
};
