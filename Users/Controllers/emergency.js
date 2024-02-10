const User = require('../../Models/user');
const sendSMS = require('../../Utils/sendSMS');

const sendEmergencyContact = async(req, res, next) => {
    try {
        const { name, emergency, coordinates, phoneNo } = req.body;
        
        sendSMS(name, emergency, coordinates, phoneNo)
            .then(success => {
                return res.status(200).json({ message: "SMS sent successfully!" })
            })
            .catch(err => console.log(err))


    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

module.exports = {
    sendEmergencyContact: sendEmergencyContact,
}