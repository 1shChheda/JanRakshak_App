const express = require('express');
const router = express.Router();

const emergencyCtrl = require('../Controllers/emergency');

router.post('/send-sms-contacts', emergencyCtrl.sendEmergencyContact);

module.exports = router;