const mongoose = require('mongoose');

const EmployeeremarkSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
    dateOfJoining: {
    type: Date,
    required:true,
    
  },
   remarks: {
    type: String,
    required: true,
  },


  
});

module.exports = mongoose.model('remark', EmployeeremarkSchema);
