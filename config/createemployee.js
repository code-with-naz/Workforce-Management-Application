const mongoose = require('mongoose');
const Employee = require('./model/employee'); // Adjust the path if needed

mongoose.connect('mongodb://localhost:27017/commerce', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => {
    console.log('Connected to MongoDB');

    const newEmployee = new Employee({
        name,
        mobile_no,
        dateOfJoining: new Date(dateOfJoining),
        select_emp_type,
        designation,
        salary,
        leave_month,
        shift,
        intime,
        outtime,
    });

    return newEmployee.save();
}).then(employee => {
    console.log('Employee saved:', employee);
    mongoose.connection.close();
}).catch(err => {
    console.error('Failed to create employee:', err);
    mongoose.connection.close();
});
 