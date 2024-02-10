const mongodb = require('mongodb');
const db = require('../Utils/dbConnect');

class User {
    constructor(id, name, phoneNo, emergencyContacts) {
        this._id = id ? new mongodb.ObjectId(id) : null;
        this.name = name;
        this.emergencyContacts = emergencyContacts; // { emergencyContacts: [] }


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
}

module.exports = User;