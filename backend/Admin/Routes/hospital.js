const express = require('express');
const router = express.Router();

const hospitalCtrl = require('../Controllers/hospital');

router.post('/add-hospital', hospitalCtrl.addHospital);
router.post('/edit-hospital', hospitalCtrl.updateHospitalDetails);

module.exports = router;