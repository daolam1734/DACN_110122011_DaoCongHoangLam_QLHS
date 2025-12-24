-- RESET SCHEMA for TVU HỒ SƠ ĐI NƯỚC NGOÀI
-- Drops existing tables (CASCADE) and recreates schema. Run once or when you need a full reset.
-- WARNING: This will destroy existing data.

-- Drop tables in dependency order
DROP TABLE IF EXISTS nhat_ky_he_thong CASCADE;
DROP TABLE IF EXISTS phe_duyet_dang_vien CASCADE;
DROP TABLE IF EXISTS chu_ky_so CASCADE;
DROP TABLE IF EXISTS ho_so_van_ban CASCADE;
DROP TABLE IF EXISTS van_ban_dien_tu CASCADE;
DROP TABLE IF EXISTS tep_dinh_kem CASCADE;
DROP TABLE IF EXISTS cau_hinh_giay_to CASCADE;
DROP TABLE IF EXISTS loai_giay_to CASCADE;
DROP TABLE IF EXISTS lich_su_hanh_dong CASCADE;
DROP TABLE IF EXISTS hanh_dong_nghiep_vu CASCADE;
DROP TABLE IF EXISTS ho_so_xu_ly CASCADE;
DROP TABLE IF EXISTS buoc_xu_ly CASCADE;
DROP TABLE IF EXISTS quy_trinh_xu_ly CASCADE;
DROP TABLE IF EXISTS vai_tro_xu_ly CASCADE;
DROP TABLE IF EXISTS ket_qua_chuyen_di CASCADE;
DROP TABLE IF EXISTS trang_thai_ho_so CASCADE;
DROP TABLE IF EXISTS ho_so_di_nuoc_ngoai CASCADE;
DROP TABLE IF EXISTS loai_ho_so CASCADE;
DROP TABLE IF EXISTS nguoi_dung_vai_tro CASCADE;
DROP TABLE IF EXISTS vai_tro_he_thong CASCADE;
DROP TABLE IF EXISTS qua_trinh_cong_tac CASCADE;
DROP TABLE IF EXISTS nguoi_dung CASCADE;
DROP TABLE IF EXISTS trang_thai_dang_vien CASCADE;
DROP TABLE IF EXISTS chuc_vu CASCADE;
DROP TABLE IF EXISTS don_vi_to_chuc CASCADE;
DROP TABLE IF EXISTS cap_to_chuc CASCADE;
DROP TABLE IF EXISTS vai_tro_van_ban CASCADE;
DROP TABLE IF EXISTS van_ban_dien_tu CASCADE; -- redundant-safe
DROP TABLE IF EXISTS chu_ky_so CASCADE;

-- Recreate schema (from provided SQL)

-- 1. CẤP TỔ CHỨC
CREATE TABLE cap_to_chuc (
    id SERIAL PRIMARY KEY,
    ma_cap VARCHAR(30) UNIQUE NOT NULL,
    ten_cap VARCHAR(100) NOT NULL
);

-- 2. ĐƠN VỊ TỔ CHỨC
CREATE TABLE don_vi_to_chuc (
    id SERIAL PRIMARY KEY,
    ma_don_vi VARCHAR(30) UNIQUE NOT NULL,
    ten_don_vi VARCHAR(150) NOT NULL,
    cap_to_chuc_id INT NOT NULL,
    don_vi_cha_id INT,
    CONSTRAINT fk_donvi_cap FOREIGN KEY (cap_to_chuc_id)
        REFERENCES cap_to_chuc(id),
    CONSTRAINT fk_donvi_cha FOREIGN KEY (don_vi_cha_id)
        REFERENCES don_vi_to_chuc(id)
);
CREATE INDEX idx_donvi_cap ON don_vi_to_chuc(cap_to_chuc_id);

-- 3. CHỨC VỤ
CREATE TABLE chuc_vu (
    id SERIAL PRIMARY KEY,
    ma_chuc_vu VARCHAR(30) UNIQUE NOT NULL,
    ten_chuc_vu VARCHAR(100) NOT NULL
);

-- 4. TRẠNG THÁI ĐẢNG VIÊN
CREATE TABLE trang_thai_dang_vien (
    id SERIAL PRIMARY KEY,
    ma_trang_thai VARCHAR(30) UNIQUE NOT NULL,
    ten_trang_thai VARCHAR(100) NOT NULL
);

-- 5. NGƯỜI DÙNG
CREATE TABLE nguoi_dung (
    id SERIAL PRIMARY KEY,
    ten_dang_nhap VARCHAR(50) UNIQUE NOT NULL,
    mat_khau_ma_hoa TEXT NOT NULL,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    dien_thoai VARCHAR(20),
    trang_thai_dang_vien_id INT,
    dang_hoat_dong BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_nd_dangvien FOREIGN KEY (trang_thai_dang_vien_id)
        REFERENCES trang_thai_dang_vien(id)
);
CREATE INDEX idx_nd_trangthai ON nguoi_dung(trang_thai_dang_vien_id);

-- 6. QUÁ TRÌNH CÔNG TÁC
CREATE TABLE qua_trinh_cong_tac (
    id SERIAL PRIMARY KEY,
    nguoi_dung_id INT NOT NULL,
    don_vi_id INT NOT NULL,
    chuc_vu_id INT NOT NULL,
    tu_ngay DATE NOT NULL,
    den_ngay DATE,
    CONSTRAINT fk_qtct_nd FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_qtct_dv FOREIGN KEY (don_vi_id) REFERENCES don_vi_to_chuc(id),
    CONSTRAINT fk_qtct_cv FOREIGN KEY (chuc_vu_id) REFERENCES chuc_vu(id),
    CONSTRAINT chk_qtct_ngay CHECK (den_ngay IS NULL OR tu_ngay <= den_ngay)
);
CREATE INDEX idx_qtct_nd ON qua_trinh_cong_tac(nguoi_dung_id);

-- 7. VAI TRÒ HỆ THỐNG
CREATE TABLE vai_tro_he_thong (
    id SERIAL PRIMARY KEY,
    ma_vai_tro VARCHAR(30) UNIQUE NOT NULL,
    ten_vai_tro VARCHAR(100) NOT NULL
);

-- 8. NGƯỜI DÙNG – VAI TRÒ
CREATE TABLE nguoi_dung_vai_tro (
    nguoi_dung_id INT NOT NULL,
    vai_tro_he_thong_id INT NOT NULL,
    PRIMARY KEY (nguoi_dung_id, vai_tro_he_thong_id),
    CONSTRAINT fk_ndvt_nd FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_ndvt_vt FOREIGN KEY (vai_tro_he_thong_id) REFERENCES vai_tro_he_thong(id)
);

-- 9. LOẠI HỒ SƠ
CREATE TABLE loai_ho_so (
    id SERIAL PRIMARY KEY,
    ma_loai VARCHAR(30) UNIQUE NOT NULL,
    ten_loai VARCHAR(100) NOT NULL
);

-- 10. TRẠNG THÁI HỒ SƠ
CREATE TABLE trang_thai_ho_so (
    id SERIAL PRIMARY KEY,
    ma_trang_thai VARCHAR(30) UNIQUE NOT NULL,
    ten_trang_thai VARCHAR(100) NOT NULL,
    thu_tu INT NOT NULL
);

-- 11. HỒ SƠ ĐI NƯỚC NGOÀI
CREATE TABLE ho_so_di_nuoc_ngoai (
    id SERIAL PRIMARY KEY,
    nguoi_nop_id INT NOT NULL,
    loai_ho_so_id INT NOT NULL,
    quoc_gia_den VARCHAR(100) NOT NULL,
    muc_dich TEXT,
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    trang_thai_hien_tai_id INT,
    deleted_at TIMESTAMP,
    CONSTRAINT fk_hs_nd FOREIGN KEY (nguoi_nop_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_hs_loai FOREIGN KEY (loai_ho_so_id) REFERENCES loai_ho_so(id),
    CONSTRAINT fk_hs_tt FOREIGN KEY (trang_thai_hien_tai_id) REFERENCES trang_thai_ho_so(id),
    CONSTRAINT chk_hs_ngay CHECK (
        ngay_bat_dau IS NULL
        OR ngay_ket_thuc IS NULL
        OR ngay_bat_dau <= ngay_ket_thuc
    )
);
CREATE INDEX idx_hs_nguoinop ON ho_so_di_nuoc_ngoai(nguoi_nop_id);

-- 12. KẾT QUẢ CHUYẾN ĐI
CREATE TABLE ket_qua_chuyen_di (
    id SERIAL PRIMARY KEY,
    ho_so_id INT UNIQUE NOT NULL,
    tom_tat_ket_qua TEXT,
    kien_nghi TEXT,
    ngay_nop DATE,
    CONSTRAINT fk_kq_hs FOREIGN KEY (ho_so_id)
        REFERENCES ho_so_di_nuoc_ngoai(id)
        ON DELETE CASCADE
);

-- 13. VAI TRÒ XỬ LÝ
CREATE TABLE vai_tro_xu_ly (
    id SERIAL PRIMARY KEY,
    ma_vai_tro VARCHAR(30) UNIQUE NOT NULL,
    ten_vai_tro VARCHAR(100) NOT NULL
);

-- 14. QUY TRÌNH XỬ LÝ
CREATE TABLE quy_trinh_xu_ly (
    id SERIAL PRIMARY KEY,
    ma_quy_trinh VARCHAR(30) UNIQUE NOT NULL,
    ten_quy_trinh VARCHAR(150) NOT NULL,
    ap_dung_cho_dang_vien BOOLEAN,
    ap_dung_cho_khong_dang_vien BOOLEAN
);

-- 15. BƯỚC XỬ LÝ
CREATE TABLE buoc_xu_ly (
    id SERIAL PRIMARY KEY,
    quy_trinh_id INT NOT NULL,
    vai_tro_xu_ly_id INT NOT NULL,
    thu_tu INT NOT NULL,
    bat_buoc BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_buoc_qt FOREIGN KEY (quy_trinh_id) REFERENCES quy_trinh_xu_ly(id),
    CONSTRAINT fk_buoc_vt FOREIGN KEY (vai_tro_xu_ly_id) REFERENCES vai_tro_xu_ly(id)
);

-- 16. HỒ SƠ XỬ LÝ
CREATE TABLE ho_so_xu_ly (
    id SERIAL PRIMARY KEY,
    ho_so_id INT NOT NULL,
    vai_tro_xu_ly_id INT NOT NULL,
    nguoi_xu_ly_id INT NOT NULL,
    thu_tu_xu_ly INT,
    trang_thai_id INT,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_hsxl_hs FOREIGN KEY (ho_so_id)
        REFERENCES ho_so_di_nuoc_ngoai(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_hsxl_vt FOREIGN KEY (vai_tro_xu_ly_id) REFERENCES vai_tro_xu_ly(id),
    CONSTRAINT fk_hsxl_nd FOREIGN KEY (nguoi_xu_ly_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_hsxl_tt FOREIGN KEY (trang_thai_id) REFERENCES trang_thai_ho_so(id)
);

-- 17. HÀNH ĐỘNG NGHIỆP VỤ
CREATE TABLE hanh_dong_nghiep_vu (
    id SERIAL PRIMARY KEY,
    ma_hanh_dong VARCHAR(30) UNIQUE NOT NULL,
    ten_hanh_dong VARCHAR(100) NOT NULL
);

-- 18. LỊCH SỬ HÀNH ĐỘNG
CREATE TABLE lich_su_hanh_dong (
    id SERIAL PRIMARY KEY,
    ho_so_id INT,
    hanh_dong_id INT,
    nguoi_thuc_hien_id INT,
    ghi_chu TEXT,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_lshd_hs FOREIGN KEY (ho_so_id) REFERENCES ho_so_di_nuoc_ngoai(id),
    CONSTRAINT fk_lshd_hd FOREIGN KEY (hanh_dong_id) REFERENCES hanh_dong_nghiep_vu(id),
    CONSTRAINT fk_lshd_nd FOREIGN KEY (nguoi_thuc_hien_id) REFERENCES nguoi_dung(id)
);

-- 19. LOẠI GIẤY TỜ
CREATE TABLE loai_giay_to (
    id SERIAL PRIMARY KEY,
    ma_giay_to VARCHAR(30) UNIQUE NOT NULL,
    ten_giay_to VARCHAR(150) NOT NULL,
    bat_buoc BOOLEAN DEFAULT FALSE
);

-- 20. CẤU HÌNH GIẤY TỜ
CREATE TABLE cau_hinh_giay_to (
    loai_ho_so_id INT NOT NULL,
    loai_giay_to_id INT NOT NULL,
    bat_buoc BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (loai_ho_so_id, loai_giay_to_id),
    CONSTRAINT fk_chgt_lhs FOREIGN KEY (loai_ho_so_id) REFERENCES loai_ho_so(id),
    CONSTRAINT fk_chgt_lgt FOREIGN KEY (loai_giay_to_id) REFERENCES loai_giay_to(id)
);

-- 21. TỆP ĐÍNH KÈM
CREATE TABLE tep_dinh_kem (
    id SERIAL PRIMARY KEY,
    ho_so_id INT NOT NULL,
    loai_giay_to_id INT,
    ten_tap_tin VARCHAR(255),
    duong_dan TEXT,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tdk_hs FOREIGN KEY (ho_so_id) REFERENCES ho_so_di_nuoc_ngoai(id),
    CONSTRAINT fk_tdk_lgt FOREIGN KEY (loai_giay_to_id) REFERENCES loai_giay_to(id)
);

-- 22. van_ban_dien_tu
CREATE TABLE van_ban_dien_tu (
    id SERIAL PRIMARY KEY,
    so_van_ban VARCHAR(50),
    trich_yeu TEXT,
    loai_van_ban VARCHAR(50),
    ngay_ban_hanh DATE,
    duong_dan_file TEXT
);

-- 23. VAI TRÒ VĂN BẢN
CREATE TABLE vai_tro_van_ban (
    id SERIAL PRIMARY KEY,
    ma_vai_tro VARCHAR(30) UNIQUE NOT NULL,
    ten_vai_tro VARCHAR(100) NOT NULL
);

-- 24. HỒ SƠ – VĂN BẢN
CREATE TABLE ho_so_van_ban (
    id SERIAL PRIMARY KEY,
    ho_so_id INT NOT NULL,
    van_ban_id INT NOT NULL,
    vai_tro_van_ban_id INT,
    CONSTRAINT fk_hsvb_hs FOREIGN KEY (ho_so_id) REFERENCES ho_so_di_nuoc_ngoai(id),
    CONSTRAINT fk_hsvb_vb FOREIGN KEY (van_ban_id) REFERENCES van_ban_dien_tu(id),
    CONSTRAINT fk_hsvb_vtvb FOREIGN KEY (vai_tro_van_ban_id) REFERENCES vai_tro_van_ban(id)
);

-- 25. TRẠNG THÁI XÁC THỰC
CREATE TABLE trang_thai_xac_thuc (
    id SERIAL PRIMARY KEY,
    ma_trang_thai VARCHAR(30) UNIQUE NOT NULL,
    ten_trang_thai VARCHAR(100) NOT NULL
);

-- 26. CHỮ KÝ SỐ (MÔ PHỎNG)
CREATE TABLE chu_ky_so (
    id SERIAL PRIMARY KEY,
    van_ban_id INT NOT NULL,
    nguoi_ky_id INT NOT NULL,
    chung_thu_so TEXT,
    thoi_gian_ky TIMESTAMP,
    trang_thai_xac_thuc_id INT,
    CONSTRAINT fk_ck_vb FOREIGN KEY (van_ban_id) REFERENCES van_ban_dien_tu(id),
    CONSTRAINT fk_ck_nd FOREIGN KEY (nguoi_ky_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_ck_xt FOREIGN KEY (trang_thai_xac_thuc_id) REFERENCES trang_thai_xac_thuc(id)
);

-- 27. PHÊ DUYỆT ĐẢNG VIÊN
CREATE TABLE phe_duyet_dang_vien (
    id SERIAL PRIMARY KEY,
    ho_so_id INT UNIQUE NOT NULL,
    nguoi_phe_duyet VARCHAR(150),
    ngay_phe_duyet DATE,
    ghi_chu TEXT,
    CONSTRAINT fk_pd_hs FOREIGN KEY (ho_so_id)
        REFERENCES ho_so_di_nuoc_ngoai(id)
);

-- 28. NHẬT KÝ HỆ THỐNG
CREATE TABLE nhat_ky_he_thong (
    id SERIAL PRIMARY KEY,
    nguoi_thuc_hien_id INT,
    hanh_dong VARCHAR(100),
    doi_tuong VARCHAR(100),
    gia_tri_cu TEXT,
    gia_tri_moi TEXT,
    dia_chi_ip VARCHAR(50),
    thiet_bi TEXT,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_nk_nd FOREIGN KEY (nguoi_thuc_hien_id) REFERENCES nguoi_dung(id)
);

-- ============================================
-- END SCHEMA
-- ============================================
