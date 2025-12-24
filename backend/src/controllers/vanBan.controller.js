const pool = require('../config/db');

class VanBan {
  static async getAll() {
    const query = 'SELECT * FROM van_ban_dien_tu ORDER BY ngay_ban_hanh DESC';
    const { rows } = await pool.query(query);
    return rows;
  }

  static async create(vanBanData) {
    const { soVanBan, trichYeu, loaiVanBan, ngayBanHanh, duongDanFile } = vanBanData;
    const query = `
      INSERT INTO van_ban_dien_tu (so_van_ban, trich_yeu, loai_van_ban, ngay_ban_hanh, duong_dan_file)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
    `;
    const { rows } = await pool.query(query, [soVanBan, trichYeu, loaiVanBan, ngayBanHanh, duongDanFile]);
    return rows[0];
  }
}

async function getAll(req, res) {
  try {
    const vanBans = await VanBan.getAll();
    res.json({ data: vanBans });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

async function create(req, res) {
  try {
    const vanBanData = req.body;
    const vanBan = await VanBan.create(vanBanData);
    res.status(201).json({ data: vanBan });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

module.exports = { getAll, create };