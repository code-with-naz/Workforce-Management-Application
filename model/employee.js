const mongoose = require('mongoose');

const EmployeeSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  mobile_no: {
    type: String,
    required: true,
    
  },
  dateOfJoining: {
    type: Date,
    required:true,
    
  },
  select_emp_type: {
    type: String,
    required: true,
  },

  designation:{
    type: String,
    required:true,

  },
  salary: {
    type: Number,
    required: true,
  },

  leave_month:{
    type:String,
  },

  shift:{
    type:String,
    required:true,
  },

  intime:{
    type:String,
    required:true,
  },

  outtime:{
    type:String,
    required:true,
  }
  
});

module.exports = mongoose.model('Employee', EmployeeSchema);
