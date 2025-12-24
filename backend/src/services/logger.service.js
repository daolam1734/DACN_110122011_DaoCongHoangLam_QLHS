const fs = require('fs');
const path = require('path');

const logDir = path.join(__dirname, '..', '..', 'logs');
if (!fs.existsSync(logDir)) fs.mkdirSync(logDir, { recursive: true });
const authLog = path.join(logDir, 'auth.log');

function _append(line) {
  try {
    fs.appendFileSync(authLog, line + '\n', { encoding: 'utf8' });
  } catch (err) {
    // fail silently in logging
    console.error('Failed to write auth log', err);
  }
}

function logLogin({ username, success = false, reason = null, userId = null, req = null }) {
  const ts = new Date().toISOString();
  const ip = req && (req.ip || req.headers && (req.headers['x-forwarded-for'] || req.connection && req.connection.remoteAddress)) || 'unknown';
  const parts = [ts, username, userId || '', success ? 'SUCCESS' : 'FAIL', reason || '', ip];
  _append(parts.join('\t'));
}

module.exports = { logLogin };