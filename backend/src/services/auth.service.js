// auth.service.js - Authentication business logic
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const NguoiDung = require('../models/nguoiDung.model');
const { JWT_SECRET, JWT_EXPIRES_IN } = require('../config/env');

async function authenticate(username, password) {
  const user = await NguoiDung.getByUsername(username);
  if (!user || !await bcrypt.compare(password, user.mat_khau_ma_hoa) || !user.dang_hoat_dong) {
    return null;
  }
  return user;
}

function generateToken(user) {
  const roles = user.roles || [];
  const payload = {
    sub: user.id,
    username: user.ten_dang_nhap,
    roles
  };
  return jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
}

module.exports = { authenticate, generateToken };