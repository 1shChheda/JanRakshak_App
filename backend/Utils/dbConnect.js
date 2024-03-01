const mongodb = require('mongodb');
const MongoClient = mongodb.MongoClient;

let _db;

const mongoConnect = async (callback) => {
    try {
        let client = await MongoClient.connect(process.env.DB_URI)
        console.log("Connected to MongoDB!");

        _db = client.db();

        callback();
    }
    catch (error) {
        console.log(error);
        throw error;
    }
}

const getDb = () => {
    if (_db) {
        return _db;
    }
    throw 'No Database Found!'
};

module.exports = {
    mongoConnect: mongoConnect,
    getDb: getDb,
};