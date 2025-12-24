import React, { useState, useEffect } from 'react';
import MainLayout from '../../components/Layout/MainLayout';
import Table from '../../components/Table';
import Button from '../../components/Button';
import { hoSoApi } from '../../api/hoSo.api';

export default function HoSoCuaToi() {
  const [hoSos, setHoSos] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadHoSos();
  }, []);

  const loadHoSos = async () => {
    try {
      const response = await hoSoApi.getAll();
      setHoSos(response.data.data || []);
    } catch (error) {
      console.error('Error loading hồ sơ:', error);
    } finally {
      setLoading(false);
    }
  };

  const columns = [
    { key: 'id', header: 'ID' },
    { key: 'quoc_gia_den', header: 'Quốc gia' },
    { key: 'muc_dich', header: 'Mục đích' },
    { key: 'ngay_tao', header: 'Ngày tạo', render: (row) => new Date(row.ngay_tao).toLocaleDateString('vi-VN') },
    { key: 'trang_thai_hien_tai', header: 'Trạng thái' },
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
          <h1 className="text-2xl font-bold text-gray-900">Hồ sơ của tôi</h1>
          <Button onClick={() => window.location.href = '/hoso/tao-moi'}>
            Tạo hồ sơ mới
          </Button>
        </div>
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <Table columns={columns} data={hoSos} />
        </div>
      </div>
    </MainLayout>
  );
}