const express = require('express');
const cors = require('cors');
const path = require('path');

// Routes
const authRoutes = require('./routes/auth.route');
const hoSoRoutes = require('./routes/hoSo.route');
const workflowRoutes = require('./routes/workflow.route');
const vanBanRoutes = require('./routes/vanBan.route');
const userRoutes = require('./routes/user.route');

const app = express();

// Middleware
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/hoso', hoSoRoutes);
app.use('/api/workflow', workflowRoutes);
app.use('/api/vanban', vanBanRoutes);
app.use('/api/users', userRoutes);

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'not_found' });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: 'internal_server_error' });
});

module.exports = app;