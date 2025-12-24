const pool = require('../config/db');

class HoSo {
  static async getAll() {
    const query = 'SELECT * FROM ho_so_di_nuoc_ngoai ORDER BY ngay_tao DESC';
    const { rows } = await pool.query(query);
    return rows;
  }

  static async getById(id) {
    const query = 'SELECT * FROM ho_so_di_nuoc_ngoai WHERE id = $1';
    const { rows } = await pool.query(query, [id]);
    return rows[0] || null;
  }

  static async create(hoSoData) {
    const { nguoiNopId, loaiHoSoId, quocGiaDen, mucDich, ngayBatDau, ngayKetThuc } = hoSoData;
    const query = `
      INSERT INTO ho_so_di_nuoc_ngoai (nguoi_nop_id, loai_ho_so_id, quoc_gia_den, muc_dich, ngay_bat_dau, ngay_ket_thuc)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *
    `;
    const { rows } = await pool.query(query, [nguoiNopId, loaiHoSoId, quocGiaDen, mucDich, ngayBatDau, ngayKetThuc]);
    return rows[0];
  }

  static async updateStatus(id, trangThaiId) {
    const query = 'UPDATE ho_so_di_nuoc_ngoai SET trang_thai_hien_tai_id = $1 WHERE id = $2 RETURNING *';
    const { rows } = await pool.query(query, [trangThaiId, id]);
    return rows[0];
  }
}

module.exports = HoSo;