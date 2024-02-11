const mongodb = require('mongodb');
const User = require('../../Models/user');
const Hospital = require('../../Models/hospital');
const text_to_widget = require('../../Utils/text_to_widget');
const sendSMS = require('../../Utils/sendSMS');
const calculateHospitalDistances = require('../../Utils/findNearestLocation');

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

const getAllHospitalsByRank = async(req, res, next) => {

    const { userId } = req.body;

    try {

        User.findById(userId)
            .then(user => {
                const currentLatitude = user.lastEmergencyCoord[0];
                const currentLongitude = user.lastEmergencyCoord[1];
                Hospital.fetchAll()
                    .then(hospitals => {
                        const rankedHospitalsData = calculateHospitalDistances(currentLatitude, currentLongitude, hospitals);
                        return res.json(rankedHospitalsData);
                    })
                    .catch(err => console.log(err))
            })
            .catch(err => console.log(err))

    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

const nearestHospitalsInPriorityOrder = async (req, res, next) => {
    const { userId } = req.body;

    try {
        const user = await User.findById(userId);
        const currentLatitude = user.lastEmergencyCoord[0];
        const currentLongitude = user.lastEmergencyCoord[1];
        const hospitals = await Hospital.fetchAll();

        let nearestHospitals = [];

        const rankedHospitalsData = calculateHospitalDistances(currentLatitude, currentLongitude, hospitals);

        for (const obj of rankedHospitalsData) {
            try {
                const hospital = await Hospital.findOne({ name: obj.hospitalName });
                // console.log(hospital);
                nearestHospitals.push(new mongodb.ObjectId(hospital._id));
            } catch (error) {
                console.log(error);
            }
        }

        return res.json(nearestHospitals);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

const verifyResources = async(req, res, next) => {
    
};


module.exports = {
    sendWidgets: sendWidgets,
    sendEmergencyContact: sendEmergencyContact,
    getAllHospitalsByRank: getAllHospitalsByRank,
    nearestHospitalsInPriorityOrder: nearestHospitalsInPriorityOrder,
    verifyResources: verifyResources,
}