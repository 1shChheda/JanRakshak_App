const express = require('express');
const router = express.Router();

const emergencyCtrl = require('../Controllers/emergency');

//1
router.post('/send-widgets', emergencyCtrl.sendWidgets);

//2
router.post('/send-sms-contacts', emergencyCtrl.sendEmergencyContact);
// router.get('/get-hospital-ranks', emergencyCtrl.getAllHospitalsByRank);

//3
router.get('/get-nearest-locations', emergencyCtrl.nearestHospitalsInPriorityOrder); // gives a list of hospitals in nearest first order

//4
router.post('/verify-allocate-resource', emergencyCtrl.verifyResources); // gives a list of hospitals in nearest first order

module.exports = router;