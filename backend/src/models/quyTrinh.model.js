const pool = require('../config/db');

class QuyTrinh {
  static async getAll() {
    const query = 'SELECT * FROM quy_trinh_xu_ly';
    const { rows } = await pool.query(query);
    return rows;
  }

  static async getById(id) {
    const query = 'SELECT * FROM quy_trinh_xu_ly WHERE id = $1';
    const { rows } = await pool.query(query, [id]);
    return rows[0] || null;
  }

  static async getBuocXuLy(quyTrinhId) {
    const query = `
      SELECT bxl.*, vtxl.ten_vai_tro
      FROM buoc_xu_ly bxl
      JOIN vai_tro_xu_ly vtxl ON bxl.vai_tro_xu_ly_id = vtxl.id
      WHERE bxl.quy_trinh_id = $1
      ORDER BY bxl.thu_tu
    `;
    const { rows } = await pool.query(query, [quyTrinhId]);
    return rows;
  }
}

module.exports = QuyTrinh;