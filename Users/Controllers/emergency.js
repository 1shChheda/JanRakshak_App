const User = require('../../Models/user');
const text_to_widget = require('../../Utils/text_to_widget');
const sendSMS = require('../../Utils/sendSMS');

const sendWidgets = async (req, res, next) => {
    try {

        const { transcribed_text } = req.body;
        const widgetResponse = text_to_widget(transcribed_text)
            .then(result => {
                console.log(result);
                return res.status(200).json({ result });
            })

    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

const sendEmergencyContact = async(req, res, next) => {
    try {
        const { userId, coordinates } = req.body;
        User.findById(userId)
            .then(user => {
                
                const updateUser = new User(user._id, user.name, user.phoneNo, user.emergencyContacts, coordinates)
                updateUser.save()
                    .then(success => {
                        return res.status(200).json({ emergencyContacts: user.emergencyContacts })
                    })
                    .catch(err => console.log(err))
                    
                // const { name, emergency, phoneNo } = user;
                
                // sendSMS(name, emergency, coordinates, phoneNo)
                //     .then(success => {
                //         return res.status(200).json({ message: "SMS sent successfully!" })
                //     })
                //     .catch(err => console.log(err))

            })



    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

module.exports = {
    sendWidgets: sendWidgets,
    sendEmergencyContact: sendEmergencyContact,
}