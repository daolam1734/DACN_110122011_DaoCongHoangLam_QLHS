const bcrypt = require('bcryptjs');

// Simple file-local user repository for development/demo purposes.
// Replace with real DB queries in production.

const users = [];

// seed a default admin user if none exist
function ensureSeed() {
  if (users.length === 0) {
    const password = process.env.DEV_ADMIN_PASSWORD || 'P@ssw0rd';
    const hash = bcrypt.hashSync(password, 10);
    users.push({ id: 1, username: 'admin', passwordHash: hash, roles: ['admin'], active: true });
  }
}

ensureSeed();

async function getByUsername(username) {
  return users.find(u => u.username === username) || null;
}

async function getById(id) {
  return users.find(u => u.id === id) || null;
}

module.exports = { getByUsername, getById, _internal: { users } };
