const mongodb = require('mongodb');
const db = require('../Utils/dbConnect');

class Hospital {
    constructor(id, name, lat, long, resources) {
        this._id = id ? new mongodb.ObjectId(id) : null;
        this.name = name;
        this.lat = lat;
        this.long = long;
        this.resources = resources; // { resources : { ambulances: int, beds: int, doctors: int } }
    }

    save() {
        const database = db.getDb();

        if (this._id) {
            return database.collection('hospitals').updateOne({ _id: this._id }, { $set: this });
        } else {
            return database.collection('hospitals').insertOne(this)
                .then(result => console.log(result))
                .catch(err => console.log(err))
        }
    }

    static fetchAll() {
        const database = db.getDb();

        return database.collection('hospitals').find().toArray()
            .then(hospitals => {
                return hospitals;
            })
            .catch(err => console.log(err))

    }

    static findById(userId) {
        const database = db.getDb();
        
        return database.collection('hospitals').find({ _id: new mongodb.ObjectId(userId) }).toArray()
            .then(hospital => {
                return hospital[0]
            })
            .catch(err => console.log(err))
    }

    static findOne(filter) {
        const database = db.getDb();
    
        return database.collection('hospitals').findOne(filter)
            .then(user => {
                return user;
            })
            .catch(err => console.log(err));    }
    
};

module.exports = Hospital;