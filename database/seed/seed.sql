-- ============================================
-- SEED DATA – HỆ THỐNG HỒ SƠ ĐI NƯỚC NGOÀI TVU
-- Chạy sau khi đã chạy schema.sql
-- ============================================

BEGIN;

SET client_encoding = 'UTF8';

-- ============================================
-- 1. cap_to_chuc
-- ============================================
INSERT INTO cap_to_chuc (ma_cap, ten_cap) VALUES
('BO', 'Bộ'),
('TRUONG', 'Trường'),
('KHOA', 'Khoa'),
('PHONG', 'Phòng')
ON CONFLICT (ma_cap) DO NOTHING;

-- ============================================
-- 2. chuc_vu
-- ============================================
INSERT INTO chuc_vu (ma_chuc_vu, ten_chuc_vu) VALUES
('HIEU_TRUONG', 'Hiệu trưởng'),
('PHO_HIEU_TRUONG', 'Phó Hiệu trưởng'),
('TRUONG_PHONG', 'Trưởng phòng'),
('PHO_TRUONG_PHONG', 'Phó Trưởng phòng'),
('VIEN_CHUC', 'Viên chức')
ON CONFLICT (ma_chuc_vu) DO NOTHING;

-- ============================================
-- 3. trang_thai_dang_vien
-- ============================================
INSERT INTO trang_thai_dang_vien (ma_trang_thai, ten_trang_thai) VALUES
('DANG_VIEN', 'Đảng viên'),
('KHONG_DANG_VIEN', 'Không phải Đảng viên')
ON CONFLICT (ma_trang_thai) DO NOTHING;

-- ============================================
-- 4. vai_tro_he_thong
-- ============================================
INSERT INTO vai_tro_he_thong (ma_vai_tro, ten_vai_tro) VALUES
('ADMIN', 'Quản trị hệ thống'),
('VIEN_CHUC', 'Viên chức'),
('TCNS', 'Phòng Tổ chức Nhân sự'),
('LANH_DAO', 'Lãnh đạo')
ON CONFLICT (ma_vai_tro) DO NOTHING;

-- ============================================
-- 5. vai_tro_xu_ly
-- ============================================
INSERT INTO vai_tro_xu_ly (ma_vai_tro, ten_vai_tro) VALUES
('NGUOI_NOP', 'Người nộp hồ sơ'),
('TRUONG_DON_VI', 'Trưởng đơn vị'),
('PHONG_TCNS', 'Phòng Tổ chức Nhân sự'),
('HIEU_TRUONG', 'Hiệu trưởng')
ON CONFLICT (ma_vai_tro) DO NOTHING;

-- ============================================
-- 6. trang_thai_ho_so
-- ============================================
INSERT INTO trang_thai_ho_so (ma_trang_thai, ten_trang_thai, thu_tu) VALUES
('MOI_TAO', 'Mới tạo', 1),
('CHO_DUYET', 'Chờ duyệt', 2),
('DANG_XU_LY', 'Đang xử lý', 3),
('TU_CHOI', 'Từ chối', 4),
('DA_DUYET', 'Đã duyệt', 5),
('HOAN_TAT', 'Hoàn tất', 6)
ON CONFLICT (ma_trang_thai) DO NOTHING;

-- ============================================
-- 7. loai_ho_so
-- ============================================
INSERT INTO loai_ho_so (ma_loai, ten_loai) VALUES
('CONG_TAC', 'Đi công tác'),
('HOC_TAP', 'Đi học tập'),
('HOI_NGHI', 'Đi hội nghị, hội thảo')
ON CONFLICT (ma_loai) DO NOTHING;

INSERT INTO loai_giay_to (ma_giay_to, ten_giay_to, bat_buoc) VALUES
('DON_XIN', 'Đơn xin đi nước ngoài', TRUE),
('THU_MOI', 'Thư mời', TRUE),
('KE_HOACH', 'Kế hoạch công tác', FALSE),
('QUYET_DINH', 'Quyết định cử đi', FALSE)
ON CONFLICT (ma_giay_to) DO NOTHING;

INSERT INTO hanh_dong_nghiep_vu (ma_hanh_dong, ten_hanh_dong) VALUES
('TAO_HO_SO', 'Tạo hồ sơ'),
('CAP_NHAT_HO_SO', 'Cập nhật hồ sơ'),
('NOP_HO_SO', 'Nộp hồ sơ'),
('DUYET', 'Duyệt hồ sơ'),
('TU_CHOI', 'Từ chối hồ sơ'),
('KY_SO', 'Ký số văn bản')
ON CONFLICT (ma_hanh_dong) DO NOTHING;

-- Initial seed inserts (safe for development)
-- Adjust values and passwords before using in production.

INSERT INTO cap_to_chuc (ma_cap, ten_cap) VALUES
	('CAP1', 'Cấp 1'),
	('CAP2', 'Cấp 2');

INSERT INTO don_vi_to_chuc (ma_don_vi, ten_don_vi, cap_to_chuc_id) VALUES
	('DV01', 'Đơn vị 1', 1),
	('DV02', 'Đơn vị 2', 2);

INSERT INTO chuc_vu (ma_chuc_vu, ten_chuc_vu) VALUES
	('CV01', 'Chức vụ 1'),
	('CV02', 'Chức vụ 2');

INSERT INTO trang_thai_dang_vien (ma_trang_thai, ten_trang_thai) VALUES
	('TT1', 'Đang hoạt động'),
	('TT2', 'Ngưng hoạt động');

INSERT INTO loai_ho_so (ma_loai, ten_loai) VALUES
	('LHS1', 'Công tác nước ngoài');

INSERT INTO vai_tro_he_thong (ma_vai_tro, ten_vai_tro) VALUES
	('ADMIN', 'Administrator'),
	('USER', 'Regular user');

INSERT INTO loai_giay_to (ma_giay_to, ten_giay_to, bat_buoc) VALUES
	('GT01', 'Hộ chiếu', TRUE),
	('GT02', 'Thẻ căn cước', FALSE);

-- Demo user (password stored in plain text here for demo only). Replace with hashed password in real use.
INSERT INTO nguoi_dung (ten_dang_nhap, mat_khau_ma_hoa, ho_ten, email, dien_thoai, trang_thai_dang_vien_id) VALUES
	('demo', 'demo', 'Người Demo', 'demo@example.com', '0123456789', 1);
COMMIT;
