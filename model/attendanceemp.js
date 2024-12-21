const mongoose = require('mongoose');

const attendanceSchema = new mongoose.Schema({
    employeeId: {
        type: mongoose.Schema.Types.ObjectId, // Correctly use ObjectId
        required: true,
        ref: 'Employee' // Ensure this references the correct model if you have one
    },
    attendance: {
        type: Map,
        of: String, // Present, Absent, Halfday, Holiday, Notset
        required: true
    },
    date: {
        type: Date,
        default: Date.now
    }
}, { timestamps: true });

const Attendance = mongoose.model('Attendance', attendanceSchema);

module.exports = Attendance;
