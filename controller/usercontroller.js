// controllers/usercontroller.js
const userservice = require('../services/userservice');

// Register API
exports.register = async (req, res, next) => {
    try {
        const { firstname, lastname, email, password } = req.body;

        const successmsg = await userservice.registerUser(firstname, lastname, email, password);

        res.json({ status: true, success: 'User registration done' });
        
    } catch (error) {
        next(error); // Pass error to the error handling middleware
    }
}

// Login API
exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        const user = await userservice.loginUser(email, password);

        if (user) {
            res.json({ status: true, message: 'Welcome', user });
        } else {
            res.status(401).json({ status: false, message: 'Invalid credentials' });
        }
        
    } catch (error) {
        next(error); // Pass error to the error handling middleware
    }
}
