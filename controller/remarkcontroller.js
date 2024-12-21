const remarkservice = require('../services/remarkservice');
const Employeeremark = require('../model/empremark'); // Import the Employee model

// Add Employee
exports.addEmployeeremark = async (req, res, next) => {
    try {
        const { name, dateOfJoining, remarks } = req.body;

        const successmsg = await remarkservice.addEmployeeremark(name, dateOfJoining, remarks);

        res.json({ status: true, success: 'Employee remark added successfully', employee: successmsg });
    } catch (error) {
        next(error); // Pass the error to the error-handling middleware
    }
};

// Get All Employees
exports.getAllEmployeesremark = async (req, res) => {
    try {
        const employeess = await Employeeremark.find(); // Fetch employees from the database
        res.status(200).json({ data: employeess });
    } catch (error) {
        res.status(500).json({ error: 'Failed to fetch employees remark' });
    }
};
