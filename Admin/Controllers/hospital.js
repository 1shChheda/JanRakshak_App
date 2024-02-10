const Hospital = require('../../Models/hospital');

const addHospital = async(req, res, next) => {

    const { name, lat, long, resources } = req.body;

    try {
        const newHospital = new Hospital(null, name, lat, long, resources)
        newHospital.save()
            .then(result => {
                return res.status(201).json({ message: "Hospital Added!", newHospital })
            })
            .catch(err => console.log(err))


    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

const updateHospitalDetails = async(req, res, next) => {
    try {

        // Hospital.

    } catch (error) {
        console.log(error);
        return res.status(500).json({ error: error.message });
    }
};

module.exports = {
    addHospital: addHospital,
    updateHospitalDetails: updateHospitalDetails,
}