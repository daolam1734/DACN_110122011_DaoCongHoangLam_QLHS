import axiosClient from './axiosClient';

export const hoSoApi = {
  getAll: () => axiosClient.get('/hoso'),
  getById: (id) => axiosClient.get(`/hoso/${id}`),
  create: (data) => axiosClient.post('/hoso', data),
  updateStatus: (id, status) => axiosClient.put(`/hoso/${id}/status`, { trangThaiId: status }),
};