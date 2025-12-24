import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import MainLayout from '../../components/Layout/MainLayout';
import Button from '../../components/Button';
import { hoSoApi } from '../../api/hoSo.api';

export default function ChiTietHoSo() {
  const { id } = useParams();
  const [hoSo, setHoSo] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadHoSo();
  }, [id]);

  const loadHoSo = async () => {
    try {
      const response = await hoSoApi.getById(id);
      setHoSo(response.data.data);
    } catch (error) {
      console.error('Error loading hồ sơ:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <MainLayout>
        <div className="text-center">Đang tải...</div>
      </MainLayout>
    );
  }

  if (!hoSo) {
    return (
      <MainLayout>
        <div className="text-center">Không tìm thấy hồ sơ</div>
      </MainLayout>
    );
  }

  return (
    <MainLayout>
      <div className="max-w-4xl mx-auto">
        <h1 className="text-2xl font-bold text-gray-900 mb-6">Chi tiết hồ sơ</h1>
        <div className="bg-white p-6 rounded-lg shadow-sm space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700">ID</label>
              <p className="mt-1 text-sm text-gray-900">{hoSo.id}</p>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Quốc gia đến</label>
              <p className="mt-1 text-sm text-gray-900">{hoSo.quoc_gia_den}</p>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Mục đích</label>
              <p className="mt-1 text-sm text-gray-900">{hoSo.muc_dich}</p>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Ngày tạo</label>
              <p className="mt-1 text-sm text-gray-900">
                {new Date(hoSo.ngay_tao).toLocaleDateString('vi-VN')}
              </p>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Ngày bắt đầu</label>
              <p className="mt-1 text-sm text-gray-900">
                {hoSo.ngay_bat_dau ? new Date(hoSo.ngay_bat_dau).toLocaleDateString('vi-VN') : 'N/A'}
              </p>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Ngày kết thúc</label>
              <p className="mt-1 text-sm text-gray-900">
                {hoSo.ngay_ket_thuc ? new Date(hoSo.ngay_ket_thuc).toLocaleDateString('vi-VN') : 'N/A'}
              </p>
            </div>
          </div>
          <div className="flex space-x-4">
            <Button onClick={() => window.history.back()}>
              Quay lại
            </Button>
          </div>
        </div>
      </div>
    </MainLayout>
  );
}