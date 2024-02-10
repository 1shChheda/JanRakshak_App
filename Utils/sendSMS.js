const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;

const client = require('twilio')(accountSid, authToken);

const sendSMS = async(name, emergency, coordinates, phoneNo) => {
    let msgOptions = {
        from: process.env.TWILIO_FROM_NUMBER,
        to: phoneNo,
        body:  `
        EMERGENCY ALERT! ${name} is currently experiencing ${emergency}.\nCurrent Location Coordinates:\nLat:${coordinates[0]},Long:${coordinates[1]}.\nReachout to him/her IMMEDIATELY!
        `
    }

    try {
        const message = await client.messages.create(msgOptions);
        console.log(message);
    } catch (error) {
        console.log(error);
    }
};

module.exports = sendSMS;