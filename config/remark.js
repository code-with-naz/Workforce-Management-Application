const mongoose = require('mongoose');
const Employee = require('./model/empremark'); // Adjust the path if needed

mongoose.connect('mongodb://localhost:27017/commerce', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => {
    console.log('Connected to MongoDB');

    const newoneEmployee = new Employee({
        name,
        dateOfJoining: new Date(dateOfJoining),
        remarks
    });

    return newoneEmployee.save();
}).then(employee => {
    console.log('Employee remark saved:', employee);
    mongoose.connection.close();
}).catch(err => {
    console.error('Failed to create employee remark:', err);
    mongoose.connection.close();
});
 