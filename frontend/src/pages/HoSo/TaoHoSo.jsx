import React, { useState } from 'react';
import MainLayout from '../../components/Layout/MainLayout';
import Button from '../../components/Button';
import { hoSoApi } from '../../api/hoSo.api';
import { useNavigate } from 'react-router-dom';

export default function TaoHoSo() {
  const [formData, setFormData] = useState({
    loaiHoSoId: '',
    quocGiaDen: '',
    mucDich: '',
    ngayBatDau: '',
    ngayKetThuc: '',
  });
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      await hoSoApi.create(formData);
      navigate('/hoso/cua-toi');
    } catch (error) {
      console.error('Error creating hồ sơ:', error);
      alert('Có lỗi xảy ra khi tạo hồ sơ');
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  return (
    <MainLayout>
      <div className="max-w-2xl mx-auto">
        <h1 className="text-2xl font-bold text-gray-900 mb-6">Tạo hồ sơ mới</h1>
        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label className="block text-sm font-medium text-gray-700">Loại hồ sơ</label>
            <select
              name="loaiHoSoId"
              value={formData.loaiHoSoId}
              onChange={handleChange}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md"
              required
            >
              <option value="">Chọn loại hồ sơ</option>
              <option value="1">Hồ sơ đi nước ngoài (nghiên cứu)</option>
              <option value="2">Hồ sơ công tác nước ngoài</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Quốc gia đến</label>
            <input
              type="text"
              name="quocGiaDen"
              value={formData.quocGiaDen}
              onChange={handleChange}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md"
              required
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Mục đích</label>
            <textarea
              name="mucDich"
              value={formData.mucDich}
              onChange={handleChange}
              rows={4}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md"
            />
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700">Ngày bắt đầu</label>
              <input
                type="date"
                name="ngayBatDau"
                value={formData.ngayBatDau}
                onChange={handleChange}
                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Ngày kết thúc</label>
              <input
                type="date"
                name="ngayKetThuc"
                value={formData.ngayKetThuc}
                onChange={handleChange}
                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md"
              />
            </div>
          </div>
          <div className="flex space-x-4">
            <Button type="submit" disabled={loading}>
              {loading ? 'Đang tạo...' : 'Tạo hồ sơ'}
            </Button>
            <Button variant="secondary" onClick={() => navigate('/hoso/cua-toi')}>
              Hủy
            </Button>
          </div>
        </form>
      </div>
    </MainLayout>
  );
}