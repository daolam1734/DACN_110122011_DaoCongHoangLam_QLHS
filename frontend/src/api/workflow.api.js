import axiosClient from './axiosClient';

export const workflowApi = {
  getAllQuyTrinh: () => axiosClient.get('/workflow'),
  getQuyTrinhById: (id) => axiosClient.get(`/workflow/${id}`),
  getBuocXuLy: (id) => axiosClient.get(`/workflow/${id}/buoc`),
};