const express = require('express');
const router = express.Router();
const verifyToken = require('../middleware/auth');
const authorize = require('../middleware/authorize');

// Example protected admin route
router.get('/', verifyToken, authorize('admin'), (req, res) => {
  res.json({ message: 'Welcome, admin!', user: req.userDetails || req.user });
});

module.exports = router;
