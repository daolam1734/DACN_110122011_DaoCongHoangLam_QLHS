const pool = require('../config/db');

class NguoiDung {
  static async getByUsername(tenDangNhap) {
    const query = 'SELECT * FROM nguoi_dung WHERE ten_dang_nhap = $1';
    const { rows } = await pool.query(query, [tenDangNhap]);
    return rows[0] || null;
  }

  static async getById(id) {
    const query = 'SELECT * FROM nguoi_dung WHERE id = $1';
    const { rows } = await pool.query(query, [id]);
    return rows[0] || null;
  }

  static async create(userData) {
    const { tenDangNhap, matKhauMaHoa, hoTen, email, dienThoai, trangThaiDangVienId, dangHoatDong } = userData;
    const query = `
      INSERT INTO nguoi_dung (ten_dang_nhap, mat_khau_ma_hoa, ho_ten, email, dien_thoai, trang_thai_dang_vien_id, dang_hoat_dong)
      VALUES ($1, $2, $3, $4, $5, $6, $7)
      RETURNING *
    `;
    const { rows } = await pool.query(query, [tenDangNhap, matKhauMaHoa, hoTen, email, dienThoai, trangThaiDangVienId, dangHoatDong]);
    return rows[0];
  }

  static async getRoles(id) {
    const query = `
      SELECT vt.ma_vai_tro, vt.ten_vai_tro
      FROM nguoi_dung_vai_tro ndvt
      JOIN vai_tro_he_thong vt ON ndvt.vai_tro_he_thong_id = vt.id
      WHERE ndvt.nguoi_dung_id = $1
    `;
    const { rows } = await pool.query(query, [id]);
    return rows;
  }
}

module.exports = NguoiDung;