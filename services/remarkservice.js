const Employeeremark = require('../model/empremark');

exports.addEmployeeremark = async (name,dateOfJoining,remarks) => {
    const employee = new Employeeremark({
        name,
        dateOfJoining,
        remarks
    });
    return await employee.save();
};