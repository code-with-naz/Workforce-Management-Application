const employeeservice = require('../services/employeeservice');
const Employee = require('../model/employee'); // Import the Employee model

// Add Employee
exports.addEmployee = async (req, res, next) => {
    try {
        const { name, mobile_no, dateOfJoining, select_emp_type, designation, salary, leave_month, shift, intime, outtime } = req.body;

        const successmsg = await employeeservice.addEmployee(name, mobile_no, dateOfJoining, select_emp_type, designation, salary, leave_month, shift, intime, outtime);

        res.json({ status: true, success: 'Employee added successfully', employee: successmsg });
    } catch (error) {
        next(error); // Pass the error to the error-handling middleware
    }
};

// Get All Employees
exports.getAllEmployees = async (req, res) => {
    try {
        const employees = await Employee.find(); // Fetch employees from the database
        res.status(200).json({ data: employees });
    } catch (error) {
        res.status(500).json({ error: 'Failed to fetch employees' });
    }
};
