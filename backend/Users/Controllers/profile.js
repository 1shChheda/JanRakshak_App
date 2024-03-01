const User = require('../../Models/user');

const addUser = async(req, res, next) => {
    try {
        const { name, phoneNo, emergencyContacts } = req.body;

        const user = new User(null, name, phoneNo, emergencyContacts)
        user.save()
            .then(result => {
                return res.status(201).json({ message: "User Created!", user })
            })
            .catch(err => console.log(err))


    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

const getUserProfile = async(req, res, next) => {

    const { userId } = req.body;
    try {
        User.findById(userId)
        .then(user => {
            console.log(user);
            return res.status(200).json({ user })
        })
    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

module.exports = {
    addUser: addUser,
    getUserProfile: getUserProfile,
}