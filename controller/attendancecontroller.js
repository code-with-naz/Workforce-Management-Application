const Attendance = require('../model/attendanceemp');
const mongoose = require('mongoose');

exports.getAttendanceByEmployeeId = async (req, res) => {
    try {
        const employeeId = req.body.employeeId;
        
        if (!mongoose.Types.ObjectId.isValid(employeeId)) {
            return res.status(400).json({ message: 'Invalid Employee ID format' });
        }

        // Convert to ObjectId
        const objectId = new mongoose.Types.ObjectId(employeeId);

        const attendance = await Attendance.findOne({ employeeId: objectId });

        if (!attendance) {
            return res.status(404).json({ message: 'No attendance record found' });
        }

        res.json(attendance);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching attendance', error: err.message });
    }
};

exports.markAttendance = async (req, res) => {
    try {
        const employeeId =new  mongoose.Types.ObjectId(req.params.employeeId);  // Correct usage here
        const { date, status } = req.body;

        let attendance = await Attendance.findOne({ employeeId });

        if (!attendance) {
            attendance = new Attendance({ employeeId, attendance: {} });
        }

        attendance.attendance.set(date, status);

        await attendance.save();
        res.json({ message: 'Attendance updated successfully', attendance });
    } catch (err) {
        res.status(500).json({ message: 'Error updating attendance', error: err.message });
    }
};
