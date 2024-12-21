// services/employeeservice.js
const Employee = require('../model/employee');

exports.addEmployee = async (name, mobile_no, dateOfJoining, select_emp_type, designation, salary, leave_month, shift, intime, outtime) => {
    const employee = new Employee({
        name,
        mobile_no,
        dateOfJoining,
        select_emp_type,
        designation,
        salary,
        leave_month,
        shift,
        intime,
        outtime,
    });
    return await employee.save();
};
