import React, { useState, useEffect } from 'react';
import MainLayout from '../../components/Layout/MainLayout';
import Table from '../../components/Table';
import Button from '../../components/Button';
import { hoSoApi } from '../../api/hoSo.api';

export default function HoSoChoXuLy() {
  const [hoSos, setHoSos] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadHoSos();
  }, []);

  const loadHoSos = async () => {
    try {
      // For demo, load all hồ sơ. In real app, filter by status or assigned to user
      const response = await hoSoApi.getAll();
      setHoSos(response.data.data || []);
    } catch (error) {
      console.error('Error loading hồ sơ:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleApprove = async (hoSoId) => {
    try {
      await hoSoApi.updateStatus(hoSoId, 2); // Assume 2 is approved
      loadHoSos();
    } catch (error) {
      console.error('Error approving hồ sơ:', error);
    }
  };

  const columns = [
    { key: 'id', header: 'ID' },
    { key: 'quoc_gia_den', header: 'Quốc gia' },
    { key: 'muc_dich', header: 'Mục đích' },
    { key: 'ngay_tao', header: 'Ngày tạo', render: (row) => new Date(row.ngay_tao).toLocaleDateString('vi-VN') },
    {
      key: 'actions',
      header: 'Thao tác',
      render: (row) => (
        <div className="space-x-2">
          <Button size="sm" onClick={(e) => { e.stopPropagation(); handleApprove(row.id); }}>
            Duyệt
          </Button>
          <Button size="sm" variant="danger" onClick={(e) => { e.stopPropagation(); /* reject */ }}>
            Từ chối
          </Button>
        </div>
      ),
    },
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
        <h1 className="text-2xl font-bold text-gray-900">Hồ sơ chờ xử lý</h1>
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <Table columns={columns} data={hoSos} />
        </div>
      </div>
    </MainLayout>
  );
}