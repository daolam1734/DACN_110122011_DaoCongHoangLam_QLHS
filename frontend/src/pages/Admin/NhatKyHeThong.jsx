import React, { useState, useEffect } from 'react';
import MainLayout from '../../components/Layout/MainLayout';
import Table from '../../components/Table';

export default function NhatKyHeThong() {
  const [logs, setLogs] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Mock data for demo
    setLogs([
      { id: 1, nguoiThucHien: 'admin', hanhDong: 'Đăng nhập', doiTuong: 'Hệ thống', thoiGian: '2023-12-01 10:00' },
      { id: 2, nguoiThucHien: 'staff', hanhDong: 'Tạo hồ sơ', doiTuong: 'Hồ sơ', thoiGian: '2023-12-01 11:00' },
    ]);
    setLoading(false);
  }, []);

  const columns = [
    { key: 'id', header: 'ID' },
    { key: 'nguoiThucHien', header: 'Người thực hiện' },
    { key: 'hanhDong', header: 'Hành động' },
    { key: 'doiTuong', header: 'Đối tượng' },
    { key: 'thoiGian', header: 'Thời gian' },
  ];

  if (loading) {
    return (
      <MainLayout>
        <div className="text-center">Đang tải...</div>
      </MainLayout>
    );
  }

  return (
    <MainLayout>
      <div className="space-y-6">
        <h1 className="text-2xl font-bold text-gray-900">Nhật ký hệ thống</h1>
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <Table columns={columns} data={logs} />
        </div>
      </div>
    </MainLayout>
  );
}