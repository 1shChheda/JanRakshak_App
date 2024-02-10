const mongodb = require('mongodb');
const db = require('../Utils/dbConnect');

class User {
    constructor(id, name, phoneNo, emergencyContacts, lastEmergencyCoord) {
        this._id = id ? new mongodb.ObjectId(id) : null;
        this.name = name;
        this.phoneNo = phoneNo;
        this.emergencyContacts = emergencyContacts; // { emergencyContacts: [] }
        this.lastEmergencyCoord = lastEmergencyCoord; // { lastEmergencyCoord : [lat, lon] }
    }

    save() {
        const database = db.getDb();

        if (this._id) {
            return database.collection('users').updateOne({ _id: this._id }, { $set: this });
        } else {
            return database.collection('users').insertOne(this)
                .then(result => console.log(result))
                .catch(err => console.log(err))
        }
    }

    static findById(userId) {
        const database = db.getDb();
        
        return database.collection('users').find({ _id: new mongodb.ObjectId(userId) }).toArray()
            .then(users => {
                return users[0]
            })
            .catch(err => console.log(err))
    }
}

module.exports = User;