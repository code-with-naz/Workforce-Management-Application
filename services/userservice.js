const UserModel = require('../model/usermodel');
const bcrypt = require('bcryptjs'); // Ensure bcrypt is imported

class UserService {
    static async registerUser(firstname, lastname, email, password) {
        try {
            
            const createUser = new UserModel({ firstname, lastname, email, password: password });
            return await createUser.save();
        } catch (error) {
            throw error;
        }
    }

    static async loginUser(email, password) {
        try {
            const user = await UserModel.findOne({ email }); // Use findOne to get a single user

            if (user && user.password) {
                return user;
            }
            
            return null;
        } catch (error) {
            throw error;
        }
    }
}

module.exports = UserService;
