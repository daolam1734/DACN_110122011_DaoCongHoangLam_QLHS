const NguoiDung = require('../models/nguoiDung.model');

async function getAll(req, res) {
  try {
    // Simple query for all users
    const pool = require('../config/db');
    const query = 'SELECT id, ten_dang_nhap, ho_ten, email, dien_thoai, dang_hoat_dong FROM nguoi_dung';
    const { rows } = await pool.query(query);
    res.json({ data: rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

async function getById(req, res) {
  try {
    const { id } = req.params;
    const user = await NguoiDung.getById(id);
    if (!user) return res.status(404).json({ error: 'not_found' });
    const { mat_khau_ma_hoa, ...safe } = user;
    res.json({ data: safe });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

module.exports = { getAll, getById };