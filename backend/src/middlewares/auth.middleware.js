const jwt = require('jsonwebtoken');
const NguoiDung = require('../models/nguoiDung.model');
const { JWT_SECRET } = require('../config/env');

// Middleware: verify Bearer token and attach user payload and full user to req
module.exports = async function authMiddleware(req, res, next) {
  try {
    const auth = req.headers && req.headers.authorization;
    if (!auth || !auth.startsWith('Bearer ')) return res.status(401).json({ error: 'missing_token' });
    const token = auth.slice('Bearer '.length);
    let payload;
    try {
      payload = jwt.verify(token, JWT_SECRET);
    } catch (err) {
      return res.status(401).json({ error: 'invalid_token' });
    }

    // attach token payload
    req.user = payload || {};

    // optionally load full user from model if sub exists
    if (payload && payload.sub) {
      const u = await NguoiDung.getById(payload.sub).catch(() => null);
      if (u) {
        // do not expose password
        const { mat_khau_ma_hoa, ...safe } = u;
        req.userDetails = safe;
      }
    }

    return next();
  } catch (err) {
    console.error('auth middleware error', err);
    return res.status(500).json({ error: 'auth_error' });
  }
};