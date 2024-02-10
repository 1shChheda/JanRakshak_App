const express = require('express');
const router = express.Router();

const emergencyCtrl = require('../Controllers/emergency');

router.post('/send-sms-contacts', emergencyCtrl.sendEmergencyContact);
router.post('/send-widgets', emergencyCtrl.sendWidgets);

module.exports = router;