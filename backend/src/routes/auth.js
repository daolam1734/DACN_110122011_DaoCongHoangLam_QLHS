const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const userRepo = require('../services/userRepo');
const logger = require('../services/logger');

const JWT_SECRET = process.env.JWT_SECRET || 'dev_secret_change_me';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '1h';

// POST /auth/login
router.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body || {};
    // Basic validation
    if (!username || !password) {
      return res.status(400).json({ error: 'username and password required' });
    }

    const user = await userRepo.getByUsername(username);
    if (!user) {
      logger.logLogin({ username, success: false, reason: 'not_found', req });
      return res.status(401).json({ error: 'invalid credentials' });
    }

    // compare password
    const ok = await bcrypt.compare(password, user.passwordHash);
    if (!ok) {
      logger.logLogin({ username, success: false, reason: 'bad_password', userId: user.id, req });
      return res.status(401).json({ error: 'invalid credentials' });
    }

    // check active
    if (user.active === false) {
      logger.logLogin({ username, success: false, reason: 'inactive', userId: user.id, req });
      return res.status(403).json({ error: 'account inactive' });
    }

    // build payload
    const payload = {
      sub: user.id,
      username: user.username,
      roles: user.roles || []
    };

    const token = jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });

    logger.logLogin({ username, success: true, userId: user.id, req });

    return res.json({ token, expiresIn: JWT_EXPIRES_IN, user: { id: user.id, username: user.username, roles: user.roles } });
  } catch (err) {
    console.error('Login error', err);
    return res.status(500).json({ error: 'internal_error' });
  }
});

module.exports = router;
