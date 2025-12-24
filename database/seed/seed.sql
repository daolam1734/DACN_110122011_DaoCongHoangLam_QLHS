-- Seed data for TVU Hồ sơ đi nước ngoài system

-- 1️⃣ CẤP TỔ CHỨC
INSERT INTO cap_to_chuc (ma_cap, ten_cap) VALUES
('TRUONG', 'Trường Đại học'),
('KHOA', 'Khoa'),
('PHONG', 'Phòng/Ban');

-- 2️⃣ ĐƠN VỊ TỔ CHỨC
INSERT INTO don_vi_to_chuc (ma_don_vi, ten_don_vi, cap_to_chuc_id, don_vi_cha_id) VALUES
('TVU', 'Trường Đại học Trà Vinh', 1, NULL),
('CNTT', 'Khoa Công nghệ Thông tin', 2, 1),
('TCHC', 'Phòng Tổ chức - Hành chính', 3, 1);

-- 3️⃣ CHỨC VỤ
INSERT INTO chuc_vu (ma_chuc_vu, ten_chuc_vu) VALUES
('GV', 'Giảng viên'),
('TP', 'Trưởng phòng'),
('NV', 'Nhân viên');

-- 4️⃣ TRẠNG THÁI ĐẢNG VIÊN
INSERT INTO trang_thai_dang_vien (ma_trang_thai, ten_trang_thai) VALUES
('DV', 'Đảng viên'),
('KDV', 'Không là Đảng viên');

-- 5️⃣ NGƯỜI DÙNG
-- ⚠️ mat_khau_ma_hoa dùng chuỗi giả lập (ví dụ: bcrypt hash)
INSERT INTO nguoi_dung
(ten_dang_nhap, mat_khau_ma_hoa, ho_ten, email, dien_thoai, trang_thai_dang_vien_id) VALUES
('gv_a', '$2b$10$hashed_pw_example_gv_a', 'Nguyễn Văn A', 'a@tvu.edu.vn', '090000001', 1),
('cb_b', '$2b$10$hashed_pw_example_cb_b', 'Trần Thị B', 'b@tvu.edu.vn', '090000002', 2),
('ld_c', '$2b$10$hashed_pw_example_ld_c', 'Lê Văn C', 'c@tvu.edu.vn', '090000003', 1);

-- 6️⃣ QUÁ TRÌNH CÔNG TÁC
INSERT INTO qua_trinh_cong_tac
(nguoi_dung_id, don_vi_id, chuc_vu_id, tu_ngay) VALUES
(1, 2, 1, '2020-01-01'),
(2, 3, 3, '2019-01-01'),
(3, 1, 2, '2018-01-01');

-- 7️⃣ VAI TRÒ HỆ THỐNG
INSERT INTO vai_tro_he_thong (ma_vai_tro, ten_vai_tro) VALUES
('VIEN_CHUC', 'Viên chức'),
('CAN_BO', 'Cán bộ xử lý'),
('LANH_DAO', 'Lãnh đạo'),
('ADMIN', 'Quản trị');

-- 8️⃣ NGƯỜI DÙNG – VAI TRÒ
INSERT INTO nguoi_dung_vai_tro VALUES
(1, 1),
(2, 2),
(3, 3);

-- 9️⃣ LOẠI HỒ SƠ
INSERT INTO loai_ho_so (ma_loai, ten_loai) VALUES
('CONG_TAC', 'Đi công tác'),
('HOI_THAO', 'Đi hội thảo');

-- 🔟 TRẠNG THÁI HỒ SƠ
INSERT INTO trang_thai_ho_so (ma_trang_thai, ten_trang_thai, thu_tu) VALUES
('NHAP', 'Nháp', 1),
('CHO_XU_LY', 'Chờ xử lý', 2),
('DA_DUYET', 'Đã duyệt', 3),
('TU_CHOI', 'Từ chối', 4);

-- 1️⃣1️⃣ HỒ SƠ ĐI NƯỚC NGOÀI
INSERT INTO ho_so_di_nuoc_ngoai
(nguoi_nop_id, loai_ho_so_id, quoc_gia_den, muc_dich, ngay_bat_dau, ngay_ket_thuc, trang_thai_hien_tai_id)
VALUES
(1, 1, 'Nhật Bản', 'Tham gia hội thảo khoa học', '2024-05-01', '2024-05-10', 2);

-- 1️⃣2️⃣ KẾT QUẢ CHUYẾN ĐI
INSERT INTO ket_qua_chuyen_di
(ho_so_id, tom_tat_ket_qua, kien_nghi, ngay_nop)
VALUES
(1, 'Hoàn thành tốt', 'Đề xuất hợp tác', '2024-06-01');

-- 1️⃣3️⃣ VAI TRÒ XỬ LÝ
INSERT INTO vai_tro_xu_ly (ma_vai_tro, ten_vai_tro) VALUES
('TIEP_NHAN', 'Tiếp nhận'),
('PHE_DUYET', 'Phê duyệt');

-- 1️⃣4️⃣ QUY TRÌNH XỬ LÝ
INSERT INTO quy_trinh_xu_ly
(ma_quy_trinh, ten_quy_trinh, ap_dung_cho_dang_vien, ap_dung_cho_khong_dang_vien)
VALUES
('QT_DV', 'Quy trình Đảng viên', TRUE, FALSE);

-- 1️⃣5️⃣ BƯỚC XỬ LÝ
INSERT INTO buoc_xu_ly (quy_trinh_id, vai_tro_xu_ly_id, thu_tu) VALUES
(1, 1, 1),
(1, 2, 2);

-- 1️⃣6️⃣ HỒ SƠ XỬ LÝ
INSERT INTO ho_so_xu_ly
(ho_so_id, vai_tro_xu_ly_id, nguoi_xu_ly_id, thu_tu_xu_ly, trang_thai_id)
VALUES
(1, 1, 2, 1, 2);

-- 1️⃣7️⃣ HÀNH ĐỘNG NGHIỆP VỤ
INSERT INTO hanh_dong_nghiep_vu (ma_hanh_dong, ten_hanh_dong) VALUES
('TAO', 'Tạo hồ sơ'),
('DUYET', 'Duyệt hồ sơ');

-- 1️⃣8️⃣ LỊCH SỬ HÀNH ĐỘNG
INSERT INTO lich_su_hanh_dong
(ho_so_id, hanh_dong_id, nguoi_thuc_hien_id, ghi_chu)
VALUES
(1, 1, 1, 'Tạo hồ sơ ban đầu');

-- 1️⃣9️⃣ LOẠI GIẤY TỜ
INSERT INTO loai_giay_to (ma_giay_to, ten_giay_to, bat_buoc) VALUES
('QD', 'Quyết định cử đi', TRUE),
('CV', 'Công văn', FALSE);

-- 2️⃣0️⃣ CẤU HÌNH GIẤY TỜ
INSERT INTO cau_hinh_giay_to VALUES
(1, 1, TRUE),
(1, 2, FALSE);

-- 2️⃣1️⃣ TỆP ĐÍNH KÈM
INSERT INTO tep_dinh_kem
(ho_so_id, loai_giay_to_id, ten_tap_tin, duong_dan)
VALUES
(1, 1, 'quyet_dinh.pdf', '/uploads/qd.pdf');

-- 2️⃣2️⃣ VĂN BẢN ĐIỆN TỬ
INSERT INTO van_ban_dien_tu
(so_van_ban, trich_yeu, loai_van_ban, ngay_ban_hanh, duong_dan_file)
VALUES
('123/QD-TVU', 'Quyết định cử đi công tác', 'Quyết định', '2024-04-01', '/uploads/qd_ct.pdf');

-- 2️⃣3️⃣ VAI TRÒ VĂN BẢN
INSERT INTO vai_tro_van_ban (ma_vai_tro, ten_vai_tro) VALUES
('QD', 'Quyết định');

-- 2️⃣4️⃣ HỒ SƠ – VĂN BẢN
INSERT INTO ho_so_van_ban
(ho_so_id, van_ban_id, vai_tro_van_ban_id)
VALUES
(1, 1, 1);

-- 2️⃣5️⃣ TRẠNG THÁI XÁC THỰC
INSERT INTO trang_thai_xac_thuc (ma_trang_thai, ten_trang_thai) VALUES
('DA_KY', 'Đã ký'),
('CHUA_KY', 'Chưa ký');

-- 2️⃣6️⃣ CHỮ KÝ SỐ (MÔ PHỎNG)
INSERT INTO chu_ky_so
(van_ban_id, nguoi_ky_id, chung_thu_so, trang_thai_xac_thuc_id)
VALUES
(1, 3, 'CERT_SAMPLE', 1);

-- 2️⃣7️⃣ PHÊ DUYỆT ĐẢNG VIÊN
INSERT INTO phe_duyet_dang_vien
(ho_so_id, nguoi_phe_duyet, ngay_phe_duyet)
VALUES
(1, 'Bí thư Đảng uỷ', '2024-04-15');

-- 2️⃣8️⃣ NHẬT KÝ HỆ THỐNG
INSERT INTO nhat_ky_he_thong
(nguoi_thuc_hien_id, hanh_dong, doi_tuong, dia_chi_ip)
VALUES
(2, 'DUYET_HO_SO', 'HO_SO', '127.0.0.1');
