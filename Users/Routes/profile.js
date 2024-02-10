const express = require('express');
const router = express.Router();

const profileCtrl = require('../Controllers/profile');

router.post('/add-user', profileCtrl.addUser);

module.exports = router;