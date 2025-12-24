const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const NguoiDung = require('../models/nguoiDung.model');
const logger = require('../services/logger.service');
const { JWT_SECRET, JWT_EXPIRES_IN } = require('../config/env');

async function login(req, res) {
  try {
    const { username, password } = req.body;
    if (!username || !password) {
      return res.status(400).json({ error: 'username and password required' });
    }

    const user = await NguoiDung.getByUsername(username);
    if (!user) {
      logger.logLogin({ username, success: false, reason: 'not_found' });
      return res.status(401).json({ error: 'invalid credentials' });
    }

    const ok = await bcrypt.compare(password, user.mat_khau_ma_hoa);
    if (!ok) {
      logger.logLogin({ username, success: false, reason: 'bad_password', userId: user.id });
      return res.status(401).json({ error: 'invalid credentials' });
    }

    if (!user.dang_hoat_dong) {
      logger.logLogin({ username, success: false, reason: 'inactive', userId: user.id });
      return res.status(403).json({ error: 'account inactive' });
    }

    const roles = await NguoiDung.getRoles(user.id);
    const payload = {
      sub: user.id,
      username: user.ten_dang_nhap,
      roles: roles.map(r => r.ma_vai_tro)
    };

    const token = jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });

    logger.logLogin({ username, success: true, userId: user.id });

    return res.json({
      token,
      expiresIn: JWT_EXPIRES_IN,
      user: { id: user.id, username: user.ten_dang_nhap, roles: payload.roles }
    });
  } catch (err) {
    console.error('Login error', err);
    return res.status(500).json({ error: 'internal_error' });
  }
}

async function getMe(req, res) {
  try {
    const user = req.userDetails;
    if (!user) return res.status(404).json({ error: 'user_not_found' });
    const { mat_khau_ma_hoa, ...safe } = user;
    return res.json({ user: safe });
  } catch (err) {
    console.error('GET /me error', err);
    return res.status(500).json({ error: 'internal_error' });
  }
}

module.exports = { login, getMe };