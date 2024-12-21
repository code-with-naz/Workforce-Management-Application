// models/user.js
const mongoose = require('mongoose');

const { Schema } = mongoose;

const userSchema = new Schema({
    firstname: {
        type: String,
        required: true,
    },
    lastname: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        lowercase: true,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    }
});

const UserModel = mongoose.model('User', userSchema); // Use 'User' instead of 'users'

module.exports = UserModel;
