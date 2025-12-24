import React, { useState, useEffect } from 'react';
import MainLayout from '../../components/Layout/MainLayout';
import Table from '../../components/Table';

export default function LichSuXuLy() {
  const [lichSu, setLichSu] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Mock data for demo
    setLichSu([
      { id: 1, hoSoId: 1, hanhDong: 'Tạo hồ sơ', nguoiThucHien: 'admin', thoiGian: '2023-12-01' },
      { id: 2, hoSoId: 1, hanhDong: 'Duyệt hồ sơ', nguoiThucHien: 'staff', thoiGian: '2023-12-02' },
    ]);
    setLoading(false);
  }, []);

  const columns = [
    { key: 'id', header: 'ID' },
    { key: 'hoSoId', header: 'Hồ sơ ID' },
    { key: 'hanhDong', header: 'Hành động' },
    { key: 'nguoiThucHien', header: 'Người thực hiện' },
    { key: 'thoiGian', header: 'Thời gian', render: (row) => new Date(row.thoiGian).toLocaleDateString('vi-VN') },
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
        <h1 className="text-2xl font-bold text-gray-900">Lịch sử xử lý</h1>
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <Table columns={columns} data={lichSu} />
        </div>
      </div>
    </MainLayout>
  );
}