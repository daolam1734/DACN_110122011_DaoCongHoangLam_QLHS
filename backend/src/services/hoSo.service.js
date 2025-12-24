// hoSo.service.js - Hồ sơ business logic
const HoSo = require('../models/hoSo.model');

async function createHoSo(hoSoData) {
  // Add validation or business rules here
  return await HoSo.create(hoSoData);
}

async function getHoSosByUser(userId) {
  // Custom query
  const pool = require('../config/db');
  const query = 'SELECT * FROM ho_so_di_nuoc_ngoai WHERE nguoi_nop_id = $1 ORDER BY ngay_tao DESC';
  const { rows } = await pool.query(query, [userId]);
  return rows;
}

module.exports = { createHoSo, getHoSosByUser };