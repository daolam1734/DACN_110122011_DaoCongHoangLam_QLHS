-- RESET DATA only (remove existing rows, keep schema intact)
-- WARNING: This will DELETE existing data. Make a backup before running.

-- Ensure pgcrypto is available for bcrypt hashing
CREATE EXTENSION IF NOT EXISTS pgcrypto;

BEGIN;

-- Truncate all application tables (identities will be reset)
TRUNCATE TABLE
  nhat_ky_he_thong,
  phe_duyet_dang_vien,
  chu_ky_so,
  ho_so_van_ban,
  van_ban_dien_tu,
  tep_dinh_kem,
  cau_hinh_giay_to,
  loai_giay_to,
  lich_su_hanh_dong,
  hanh_dong_nghiep_vu,
  ho_so_xu_ly,
  buoc_xu_ly,
  quy_trinh_xu_ly,
  vai_tro_xu_ly,
  ket_qua_chuyen_di,
  trang_thai_ho_so,
  ho_so_di_nuoc_ngoai,
  loai_ho_so,
  nguoi_dung_vai_tro,
  vai_tro_he_thong,
  qua_trinh_cong_tac,
  nguoi_dung,
  trang_thai_dang_vien,
  chuc_vu,
  don_vi_to_chuc,
  cap_to_chuc,
  vai_tro_van_ban
RESTART IDENTITY CASCADE;

-- Insert reference data
-- 1. cap_to_chuc
INSERT INTO cap_to_chuc (ma_cap, ten_cap) VALUES
  ('TU', 'Trường Đại học Trà Vinh'),
  ('KHOA', 'Khoa/Phòng');

-- 2. don_vi_to_chuc (example root unit)
INSERT INTO don_vi_to_chuc (ma_don_vi, ten_don_vi, cap_to_chuc_id, don_vi_cha_id)
VALUES ('DV_ROOT', 'Đơn vị gốc', (SELECT id FROM cap_to_chuc WHERE ma_cap='TU' LIMIT 1), NULL);

-- 3. chuc_vu
INSERT INTO chuc_vu (ma_chuc_vu, ten_chuc_vu) VALUES
  ('GV', 'Giảng viên'),
  ('CB', 'Cán bộ');

-- 4. trang_thai_dang_vien
INSERT INTO trang_thai_dang_vien (ma_trang_thai, ten_trang_thai) VALUES
  ('DANG', 'Đảng viên'),
  ('KHONG_DANG', 'Không đảng viên');

-- 5. vai_tro_he_thong
INSERT INTO vai_tro_he_thong (ma_vai_tro, ten_vai_tro) VALUES
  ('admin', 'Quản trị hệ thống'),
  ('staff', 'Nhân viên');

-- 6. trang_thai_ho_so
INSERT INTO trang_thai_ho_so (ma_trang_thai, ten_trang_thai, thu_tu) VALUES
  ('MOI', 'Mới', 1),
  ('DANG_XU_LY', 'Đang xử lý', 2),
  ('DA_KET_THUC', 'Đã kết thúc', 3);

-- 7. loai_ho_so
INSERT INTO loai_ho_so (ma_loai, ten_loai) VALUES
  ('NCNN', 'Hồ sơ đi nước ngoài (nghiên cứu)'),
  ('CBNN', 'Hồ sơ công tác nước ngoài');

-- 8. vai_tro_xu_ly (example)
INSERT INTO vai_tro_xu_ly (ma_vai_tro, ten_vai_tro) VALUES
  ('CBQL', 'Cán bộ quản lý'),
  ('CBYK', 'Cán bộ y/k');

-- 9. quy_trinh_xu_ly (example)
INSERT INTO quy_trinh_xu_ly (ma_quy_trinh, ten_quy_trinh, ap_dung_cho_dang_vien, ap_dung_cho_khong_dang_vien) VALUES
  ('QT_DEFAULT', 'Quy trình mặc định', TRUE, TRUE);

-- 10. hanh_dong_nghiep_vu (example)
INSERT INTO hanh_dong_nghiep_vu (ma_hanh_dong, ten_hanh_dong) VALUES
  ('CREATE', 'Tạo hồ sơ'),
  ('APPROVE', 'Phê duyệt');

-- 11. Seed admin user
-- Password: P@ssw0rd  (hashed via crypt with bcrypt)
INSERT INTO nguoi_dung (ten_dang_nhap, mat_khau_ma_hoa, ho_ten, email, dien_thoai, trang_thai_dang_vien_id, dang_hoat_dong)
VALUES (
  'admin',
  crypt('P@ssw0rd', gen_salt('bf', 10)),
  'Administrator',
  'admin@tvu.edu.vn',
  '+84000000000',
  (SELECT id FROM trang_thai_dang_vien WHERE ma_trang_thai='DANG' LIMIT 1),
  TRUE
);

-- Map admin to admin role
INSERT INTO nguoi_dung_vai_tro (nguoi_dung_id, vai_tro_he_thong_id)
VALUES (
  (SELECT id FROM nguoi_dung WHERE ten_dang_nhap='admin' LIMIT 1),
  (SELECT id FROM vai_tro_he_thong WHERE ma_vai_tro='admin' LIMIT 1)
);

COMMIT;

-- Notes:
-- - The admin password is set to 'P@ssw0rd'. You can change it by running:
--     UPDATE nguoi_dung SET mat_khau_ma_hoa = crypt('NEW_PASS', gen_salt('bf', 10)) WHERE ten_dang_nhap = 'admin';
-- - This script assumes the schema already exists. It only modifies data.
-- - Run via psql:
--     psql -h <HOST> -p <PORT> -U <USER> -d <DBNAME> -f database/reset_data.sql
