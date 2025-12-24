-- ============================================
-- SCHEMA QUẢN LÝ HỒ SƠ ĐI NƯỚC NGOÀI – TVU
-- PostgreSQL – chạy 1 lần
-- ============================================

-- 1. cap_to_chuc
CREATE TABLE cap_to_chuc (
    id SERIAL PRIMARY KEY,
    ma_cap VARCHAR(30) UNIQUE NOT NULL,
    ten_cap VARCHAR(100) NOT NULL
);

-- 2. don_vi_to_chuc
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

-- 3. chuc_vu
CREATE TABLE chuc_vu (
    id SERIAL PRIMARY KEY,
    ma_chuc_vu VARCHAR(30) UNIQUE NOT NULL,
    ten_chuc_vu VARCHAR(100) NOT NULL
);

-- 4. trang_thai_dang_vien
CREATE TABLE trang_thai_dang_vien (
    id SERIAL PRIMARY KEY,
    ma_trang_thai VARCHAR(30) UNIQUE NOT NULL,
    ten_trang_thai VARCHAR(100) NOT NULL
);

-- 5. nguoi_dung
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

-- 6. qua_trinh_cong_tac
CREATE TABLE qua_trinh_cong_tac (
    id SERIAL PRIMARY KEY,
    nguoi_dung_id INT NOT NULL,
    don_vi_id INT NOT NULL,
    chuc_vu_id INT NOT NULL,
    tu_ngay DATE NOT NULL,
    den_ngay DATE,
    CONSTRAINT fk_qtct_nd FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_qtct_dv FOREIGN KEY (don_vi_id) REFERENCES don_vi_to_chuc(id),
    CONSTRAINT fk_qtct_cv FOREIGN KEY (chuc_vu_id) REFERENCES chuc_vu(id)
);

-- 7. vai_tro_he_thong
CREATE TABLE vai_tro_he_thong (
    id SERIAL PRIMARY KEY,
    ma_vai_tro VARCHAR(30) UNIQUE NOT NULL,
    ten_vai_tro VARCHAR(100) NOT NULL
);

-- 8. nguoi_dung_vai_tro
CREATE TABLE nguoi_dung_vai_tro (
    nguoi_dung_id INT NOT NULL,
    vai_tro_he_thong_id INT NOT NULL,
    PRIMARY KEY (nguoi_dung_id, vai_tro_he_thong_id),
    CONSTRAINT fk_ndvt_nd FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_ndvt_vt FOREIGN KEY (vai_tro_he_thong_id) REFERENCES vai_tro_he_thong(id)
);

-- 9. loai_ho_so
CREATE TABLE loai_ho_so (
    id SERIAL PRIMARY KEY,
    ma_loai VARCHAR(30) UNIQUE NOT NULL,
    ten_loai VARCHAR(100) NOT NULL
);

-- 10. ho_so_di_nuoc_ngoai
CREATE TABLE ho_so_di_nuoc_ngoai (
    id SERIAL PRIMARY KEY,
    nguoi_nop_id INT NOT NULL,
    loai_ho_so_id INT NOT NULL,
    quoc_gia_den VARCHAR(100) NOT NULL,
    muc_dich TEXT,
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_hs_nd FOREIGN KEY (nguoi_nop_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_hs_loai FOREIGN KEY (loai_ho_so_id) REFERENCES loai_ho_so(id)
);
CREATE INDEX idx_hs_nguoinop ON ho_so_di_nuoc_ngoai(nguoi_nop_id);

-- 11. trang_thai_ho_so
CREATE TABLE trang_thai_ho_so (
    id SERIAL PRIMARY KEY,
    ma_trang_thai VARCHAR(30) UNIQUE NOT NULL,
    ten_trang_thai VARCHAR(100) NOT NULL,
    thu_tu INT NOT NULL
);

-- 12. ket_qua_chuyen_di
CREATE TABLE ket_qua_chuyen_di (
    id SERIAL PRIMARY KEY,
    ho_so_id INT UNIQUE NOT NULL,
    tom_tat_ket_qua TEXT,
    kien_nghi TEXT,
    ngay_nop DATE,
    CONSTRAINT fk_kq_hs FOREIGN KEY (ho_so_id)
        REFERENCES ho_so_di_nuoc_ngoai(id)
);

-- 13. vai_tro_xu_ly
CREATE TABLE vai_tro_xu_ly (
    id SERIAL PRIMARY KEY,
    ma_vai_tro VARCHAR(30) UNIQUE NOT NULL,
    ten_vai_tro VARCHAR(100) NOT NULL
);

-- 14. quy_trinh_xu_ly
CREATE TABLE quy_trinh_xu_ly (
    id SERIAL PRIMARY KEY,
    ma_quy_trinh VARCHAR(30) UNIQUE NOT NULL,
    ten_quy_trinh VARCHAR(150) NOT NULL,
    ap_dung_cho_dang_vien BOOLEAN,
    ap_dung_cho_khong_dang_vien BOOLEAN
);

-- 15. buoc_xu_ly
CREATE TABLE buoc_xu_ly (
    id SERIAL PRIMARY KEY,
    quy_trinh_id INT NOT NULL,
    vai_tro_xu_ly_id INT NOT NULL,
    thu_tu INT NOT NULL,
    bat_buoc BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_buoc_qt FOREIGN KEY (quy_trinh_id) REFERENCES quy_trinh_xu_ly(id),
    CONSTRAINT fk_buoc_vt FOREIGN KEY (vai_tro_xu_ly_id) REFERENCES vai_tro_xu_ly(id)
);

-- 16. ho_so_xu_ly
CREATE TABLE ho_so_xu_ly (
    id SERIAL PRIMARY KEY,
    ho_so_id INT NOT NULL,
    vai_tro_xu_ly_id INT NOT NULL,
    nguoi_xu_ly_id INT NOT NULL,
    thu_tu_xu_ly INT,
    trang_thai_id INT,
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_hsxl_hs FOREIGN KEY (ho_so_id) REFERENCES ho_so_di_nuoc_ngoai(id),
    CONSTRAINT fk_hsxl_vt FOREIGN KEY (vai_tro_xu_ly_id) REFERENCES vai_tro_xu_ly(id),
    CONSTRAINT fk_hsxl_nd FOREIGN KEY (nguoi_xu_ly_id) REFERENCES nguoi_dung(id),
    CONSTRAINT fk_hsxl_tt FOREIGN KEY (trang_thai_id) REFERENCES trang_thai_ho_so(id)
);

-- 17. hanh_dong_nghiep_vu
CREATE TABLE hanh_dong_nghiep_vu (
    id SERIAL PRIMARY KEY,
    ma_hanh_dong VARCHAR(30) UNIQUE NOT NULL,
    ten_hanh_dong VARCHAR(100) NOT NULL
);

-- 18. lich_su_hanh_dong
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

-- 19. loai_giay_to
CREATE TABLE loai_giay_to (
    id SERIAL PRIMARY KEY,
    ma_giay_to VARCHAR(30) UNIQUE NOT NULL,
    ten_giay_to VARCHAR(150) NOT NULL,
    bat_buoc BOOLEAN DEFAULT FALSE
);

-- 20. cau_hinh_giay_to
CREATE TABLE cau_hinh_giay_to (
    loai_ho_so_id INT NOT NULL,
    loai_giay_to_id INT NOT NULL,
    bat_buoc BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (loai_ho_so_id, loai_giay_to_id),
    CONSTRAINT fk_chgt_lhs FOREIGN KEY (loai_ho_so_id) REFERENCES loai_ho_so(id),
    CONSTRAINT fk_chgt_lgt FOREIGN KEY (loai_giay_to_id) REFERENCES loai_giay_to(id)
);

-- 21. tep_dinh_kem
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

-- 23. ho_so_van_ban
CREATE TABLE ho_so_van_ban (
    id SERIAL PRIMARY KEY,
    ho_so_id INT NOT NULL,
    van_ban_id INT NOT NULL,
    vai_tro_van_ban VARCHAR(50),
    CONSTRAINT fk_hsvb_hs FOREIGN KEY (ho_so_id) REFERENCES ho_so_di_nuoc_ngoai(id),
    CONSTRAINT fk_hsvb_vb FOREIGN KEY (van_ban_id) REFERENCES van_ban_dien_tu(id)
);

-- 24. chu_ky_so
CREATE TABLE chu_ky_so (
    id SERIAL PRIMARY KEY,
    van_ban_id INT NOT NULL,
    nguoi_ky_id INT NOT NULL,
    chung_thu_so TEXT,
    thoi_gian_ky TIMESTAMP,
    trang_thai_xac_thuc VARCHAR(50),
    CONSTRAINT fk_ck_vb FOREIGN KEY (van_ban_id) REFERENCES van_ban_dien_tu(id),
    CONSTRAINT fk_ck_nd FOREIGN KEY (nguoi_ky_id) REFERENCES nguoi_dung(id)
);

-- 25. phe_duyet_dang_vien
CREATE TABLE phe_duyet_dang_vien (
    id SERIAL PRIMARY KEY,
    ho_so_id INT UNIQUE NOT NULL,
    nguoi_phe_duyet VARCHAR(150),
    ngay_phe_duyet DATE,
    ghi_chu TEXT,
    CONSTRAINT fk_pd_hs FOREIGN KEY (ho_so_id)
        REFERENCES ho_so_di_nuoc_ngoai(id)
);

-- 26. nhat_ky_he_thong
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
