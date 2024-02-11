const express = require('express');
const router = express.Router();

const emergencyCtrl = require('../Controllers/emergency');

router.post('/send-sms-contacts', emergencyCtrl.sendEmergencyContact);
router.post('/send-widgets', emergencyCtrl.sendWidgets);
// router.get('/get-hospital-ranks', emergencyCtrl.getAllHospitalsByRank);
router.get('/get-nearest-locations', emergencyCtrl.nearestHospitalsInPriorityOrder); // gives a list of hospitals in nearest first order

module.exports = router;