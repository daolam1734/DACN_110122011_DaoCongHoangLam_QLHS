import React, { useState, useEffect } from 'react';
import MainLayout from '../../components/Layout/MainLayout';
import Table from '../../components/Table';
import Button from '../../components/Button';

export default function QuanLyNguoiDung() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Mock data for demo
    setUsers([
      { id: 1, tenDangNhap: 'admin', hoTen: 'Administrator', email: 'admin@tvu.edu.vn', dangHoatDong: true },
      { id: 2, tenDangNhap: 'staff', hoTen: 'Staff User', email: 'staff@tvu.edu.vn', dangHoatDong: true },
    ]);
    setLoading(false);
  }, []);

  const columns = [
    { key: 'id', header: 'ID' },
    { key: 'tenDangNhap', header: 'Tên đăng nhập' },
    { key: 'hoTen', header: 'Họ tên' },
    { key: 'email', header: 'Email' },
    { key: 'dangHoatDong', header: 'Trạng thái', render: (row) => row.dangHoatDong ? 'Hoạt động' : 'Không hoạt động' },
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
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-900">Quản lý người dùng</h1>
          <Button>Thêm người dùng</Button>
        </div>
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <Table columns={columns} data={users} />
        </div>
      </div>
    </MainLayout>
  );
}