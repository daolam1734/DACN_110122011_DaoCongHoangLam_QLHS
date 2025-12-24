-- ==================================================================
-- Seed data for TVU Ho So Di Nuoc Ngoai
-- Purpose: populate lookup/demo data for development and testing
-- IMPORTANT: Review and change values/passwords before using in production
-- Run with: psql -h <host> -U <user> -d tvu_hoso_dnn -f database/seed/seed.sql
-- ==================================================================

-- Ensure UTF8 client encoding
SET client_encoding = 'UTF8';

-- Run everything inside a transaction so it can be rolled back on error
BEGIN;

-- Example seed inserts (uncomment and adapt as needed)
-- INSERT INTO cap_to_chuc (ma_cap, ten_cap) VALUES ('CAP1','Cấp 1'), ('CAP2','Cấp 2');
-- INSERT INTO don_vi_to_chuc (ma_don_vi, ten_don_vi, cap_to_chuc_id) VALUES ('DV01','Đơn vị 1', 1);
-- INSERT INTO chuc_vu (ma_chuc_vu, ten_chuc_vu) VALUES ('CV01','Chức vụ 1');
-- INSERT INTO trang_thai_dang_vien (ma_trang_thai, ten_trang_thai) VALUES ('TT1','Đang hoạt động');
-- INSERT INTO loai_ho_so (ma_loai, ten_loai) VALUES ('LHS1','Loại hồ sơ 1');
-- INSERT INTO vai_tro_he_thong (ma_vai_tro, ten_vai_tro) VALUES ('ADMIN','Administrator');
-- INSERT INTO loai_giay_to (ma_giay_to, ten_giay_to, bat_buoc) VALUES ('GT01','Giấy tờ mẫu', true);

-- Optionally, add demo user (replace password/hash accordingly)
-- INSERT INTO nguoi_dung (ten_dang_nhap, mat_khau_ma_hoa, ho_ten, email, dien_thoai, trang_thai_dang_vien_id) 
-- VALUES ('demo','<hashed_password>','Người Demo','demo@example.com','0123456789', 1);

COMMIT;
