const express = require('express');
const router = express.Router();

const profileCtrl = require('../Controllers/profile');

router.post('/add-user', profileCtrl.addUser);
router.get('/user-profile', profileCtrl.getUserProfile);

module.exports = router;