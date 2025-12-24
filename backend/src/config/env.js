// env.js - Environment configuration
require('dotenv').config();

module.exports = {
  PORT: process.env.PORT || 4000,
  JWT_SECRET: process.env.JWT_SECRET || 'dev_secret_change_me',
  JWT_EXPIRES_IN: process.env.JWT_EXPIRES_IN || '1h',
  DB_HOST: process.env.DB_HOST || 'localhost',
  DB_PORT: process.env.DB_PORT || 5432,
  DB_NAME: process.env.DB_NAME || 'tvu_hoso_dnn',
  DB_USER: process.env.DB_USER || 'tvu_user',
  DB_PASSWORD: process.env.DB_PASSWORD || 'change_me',
  NODE_ENV: process.env.NODE_ENV || 'development',
};