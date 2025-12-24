-- ============================================
-- SEED DATA – QUẢN LÝ HỒ SƠ ĐI NƯỚC NGOÀI – TVU
-- Chạy sau khi đã chạy schema.sql
-- ============================================

-- 1. CẤP TỔ CHỨC
INSERT INTO
    cap_to_chuc (ma_cap, ten_cap)
VALUES ('TRUONG', 'Trường'),
    ('KHOA', 'Khoa'),
    ('PHONG', 'Phòng');

-- 2. ĐƠN VỊ TỔ CHỨC
INSERT INTO
    don_vi_to_chuc (
        ma_don_vi,
        ten_don_vi,
        cap_to_chuc_id,
        don_vi_cha_id
    )
VALUES (
        'TVU',
        'Trường Đại học Trà Vinh',
        1,
        NULL
    ),
    (
        'CNTT',
        'Khoa Công nghệ Thông tin',
        2,
        1
    ),
    (
        'TCHC',
        'Phòng Tổ chức Hành chính',
        3,
        1
    );

-- 3. CHỨC VỤ
INSERT INTO
    chuc_vu (ma_chuc_vu, ten_chuc_vu)
VALUES ('GV', 'Giảng viên'),
    ('TP', 'Trưởng phòng'),
    ('HT', 'Hiệu trưởng');

-- 4. TRẠNG THÁI ĐẢNG VIÊN
INSERT INTO
    trang_thai_dang_vien (ma_trang_thai, ten_trang_thai)
VALUES ('DV', 'Đảng viên'),
    ('KDV', 'Không phải Đảng viên');

-- 5. NGƯỜI DÙNG
INSERT INTO
    nguoi_dung (
        ten_dang_nhap,
        mat_khau_ma_hoa,
        ho_ten,
        email,
        trang_thai_dang_vien_id
    )
VALUES (
        'vienchuc01',
        'hashed_pw',
        'Nguyễn Văn A',
        'a@tvu.edu.vn',
        2
    ),
    (
        'canbo01',
        'hashed_pw',
        'Trần Thị B',
        'b@tvu.edu.vn',
        1
    ),
    (
        'lanhdao01',
        'hashed_pw',
        'Lê Văn C',
        'c@tvu.edu.vn',
        1
    );

-- 6. QUÁ TRÌNH CÔNG TÁC
INSERT INTO
    qua_trinh_cong_tac (
        nguoi_dung_id,
        don_vi_id,
        chuc_vu_id,
        tu_ngay
    )
VALUES (1, 2, 1, '2020-01-01'),
    (2, 3, 2, '2018-01-01'),
    (3, 1, 3, '2015-01-01');

-- 7. VAI TRÒ HỆ THỐNG
INSERT INTO
    vai_tro_he_thong (ma_vai_tro, ten_vai_tro)
VALUES ('VIEN_CHUC', 'Viên chức'),
    ('CAN_BO', 'Cán bộ xử lý'),
    ('LANH_DAO', 'Lãnh đạo'),
    ('ADMIN', 'Quản trị');

-- 8. NGƯỜI DÙNG – VAI TRÒ
INSERT INTO nguoi_dung_vai_tro VALUES (1, 1), (2, 2), (3, 3);

-- 9. LOẠI HỒ SƠ
INSERT INTO
    loai_ho_so (ma_loai, ten_loai)
VALUES ('CONG_TAC', 'Đi công tác'),
    ('HOI_THAO', 'Đi hội thảo');

-- 10. TRẠNG THÁI HỒ SƠ
INSERT INTO
    trang_thai_ho_so (
        ma_trang_thai,
        ten_trang_thai,
        thu_tu
    )
VALUES ('NHAP', 'Nháp', 1),
    ('CHO_XL', 'Chờ xử lý', 2),
    ('DA_DUYET', 'Đã duyệt', 3);

-- 11. HỒ SƠ ĐI NƯỚC NGOÀI
INSERT INTO
    ho_so_di_nuoc_ngoai (
        nguoi_nop_id,
        loai_ho_so_id,
        quoc_gia_den,
        muc_dich,
        ngay_bat_dau,
        ngay_ket_thuc,
        trang_thai_hien_tai_id
    )
VALUES (
        1,
        1,
        'Nhật Bản',
        'Học tập trao đổi',
        '2024-06-01',
        '2024-06-10',
        2
    );

-- 12. VAI TRÒ XỬ LÝ
INSERT INTO
    vai_tro_xu_ly (ma_vai_tro, ten_vai_tro)
VALUES ('TIEP_NHAN', 'Tiếp nhận'),
    ('PHE_DUYET', 'Phê duyệt');

-- 13. QUY TRÌNH XỬ LÝ
INSERT INTO
    quy_trinh_xu_ly (
        ma_quy_trinh,
        ten_quy_trinh,
        ap_dung_cho_dang_vien,
        ap_dung_cho_khong_dang_vien
    )
VALUES (
        'QT01',
        'Quy trình duyệt hồ sơ đi nước ngoài',
        TRUE,
        TRUE
    );

-- 14. BƯỚC XỬ LÝ
INSERT INTO
    buoc_xu_ly (
        quy_trinh_id,
        vai_tro_xu_ly_id,
        thu_tu
    )
VALUES (1, 1, 1),
    (1, 2, 2);

-- 15. HỒ SƠ XỬ LÝ
INSERT INTO
    ho_so_xu_ly (
        ho_so_id,
        vai_tro_xu_ly_id,
        nguoi_xu_ly_id,
        thu_tu_xu_ly,
        trang_thai_id
    )
VALUES (1, 1, 2, 1, 2);

-- 16. HÀNH ĐỘNG NGHIỆP VỤ
INSERT INTO
    hanh_dong_nghiep_vu (ma_hanh_dong, ten_hanh_dong)
VALUES ('NOP', 'Nộp hồ sơ'),
    ('DUYET', 'Phê duyệt');

-- 17. LỊCH SỬ HÀNH ĐỘNG
INSERT INTO
    lich_su_hanh_dong (
        ho_so_id,
        hanh_dong_id,
        nguoi_thuc_hien_id,
        ghi_chu
    )
VALUES (1, 1, 1, 'Nộp hồ sơ lần đầu');

-- 18. LOẠI GIẤY TỜ
INSERT INTO
    loai_giay_to (
        ma_giay_to,
        ten_giay_to,
        bat_buoc
    )
VALUES (
        'QD',
        'Quyết định cử đi',
        TRUE
    ),
    ('CV', 'Công văn mời', TRUE);

-- 19. CẤU HÌNH GIẤY TỜ
INSERT INTO cau_hinh_giay_to VALUES (1, 1, TRUE), (1, 2, TRUE);

-- 20. TỆP ĐÍNH KÈM
INSERT INTO
    tep_dinh_kem (
        ho_so_id,
        loai_giay_to_id,
        ten_tap_tin,
        duong_dan
    )
VALUES (
        1,
        2,
        'thu-moi.pdf',
        '/uploads/thu-moi.pdf'
    );

-- 21. VĂN BẢN ĐIỆN TỬ
INSERT INTO
    van_ban_dien_tu (
        so_van_ban,
        trich_yeu,
        loai_van_ban,
        ngay_ban_hanh,
        duong_dan_file
    )
VALUES (
        '123/QD-TVU',
        'Quyết định cử đi Nhật Bản',
        'Quyết định',
        '2024-05-01',
        '/uploads/qd.pdf'
    );

-- 22. VAI TRÒ VĂN BẢN
INSERT INTO
    vai_tro_van_ban (ma_vai_tro, ten_vai_tro)
VALUES ('QD', 'Quyết định');

-- 23. HỒ SƠ – VĂN BẢN
INSERT INTO
    ho_so_van_ban (
        ho_so_id,
        van_ban_id,
        vai_tro_van_ban_id
    )
VALUES (1, 1, 1);

-- 24. TRẠNG THÁI XÁC THỰC
INSERT INTO
    trang_thai_xac_thuc (ma_trang_thai, ten_trang_thai)
VALUES ('CHUA_KY', 'Chưa ký'),
    ('DA_KY', 'Đã ký');

-- 25. CHỮ KÝ SỐ (MÔ PHỎNG)
INSERT INTO
    chu_ky_so (
        van_ban_id,
        nguoi_ky_id,
        chung_thu_so,
        trang_thai_xac_thuc_id
    )
VALUES (1, 3, 'CERT_SAMPLE', 2);

-- 26. PHÊ DUYỆT ĐẢNG VIÊN
INSERT INTO
    phe_duyet_dang_vien (
        ho_so_id,
        nguoi_phe_duyet,
        ngay_phe_duyet
    )
VALUES (
        1,
        'Bí thư Đảng ủy',
        '2024-05-05'
    );

-- 27. NHẬT KÝ HỆ THỐNG
INSERT INTO
    nhat_ky_he_thong (
        nguoi_thuc_hien_id,
        hanh_dong,
        doi_tuong,
        dia_chi_ip
    )
VALUES (
        1,
        'LOGIN',
        'HỆ THỐNG',
        '127.0.0.1'
    );

-- ============================================
-- END SEED DATA
-- ============================================