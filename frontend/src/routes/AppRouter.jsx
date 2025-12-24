import React from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Login from '../pages/Login';
import Home from '../pages/Home';
import HoSoCuaToi from '../pages/HoSo/HoSoCuaToi';
import TaoHoSo from '../pages/HoSo/TaoHoSo';
import ChiTietHoSo from '../pages/HoSo/ChiTietHoSo';
import HoSoChoXuLy from '../pages/XuLy/HoSoChoXuLy';
import LichSuXuLy from '../pages/XuLy/LichSuXuLy';
import QuanLyNguoiDung from '../pages/Admin/QuanLyNguoiDung';
import NhatKyHeThong from '../pages/Admin/NhatKyHeThong';
import MainLayout from '../components/Layout/MainLayout';
import useAuthStore from '../store/auth.store';
import { canAccessRoute } from '../utils/role.util';

function RequireAuth({ children, requiredPermission }) {
  const { isAuthenticated, role } = useAuthStore();

  if (!isAuthenticated) return <Navigate to="/login" replace />;

  if (requiredPermission && !canAccessRoute(role, window.location.pathname)) {
    return <Navigate to="/home" replace />;
  }

  return <MainLayout>{children}</MainLayout>;
}

export default function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/home" element={<RequireAuth><Home /></RequireAuth>} />
        <Route path="/hoso/cua-toi" element={<RequireAuth><HoSoCuaToi /></RequireAuth>} />
        <Route path="/hoso/tao-moi" element={<RequireAuth><TaoHoSo /></RequireAuth>} />
        <Route path="/hoso/:id" element={<RequireAuth><ChiTietHoSo /></RequireAuth>} />
        <Route path="/xuly/cho-xu-ly" element={<RequireAuth requiredPermission="approve_hoso"><HoSoChoXuLy /></RequireAuth>} />
        <Route path="/xuly/lich-su" element={<RequireAuth requiredPermission="view_department_hoso"><LichSuXuLy /></RequireAuth>} />
        <Route path="/admin/nguoi-dung" element={<RequireAuth requiredPermission="manage_users"><QuanLyNguoiDung /></RequireAuth>} />
        <Route path="/admin/nhat-ky" element={<RequireAuth requiredPermission="view_system_logs"><NhatKyHeThong /></RequireAuth>} />
        <Route path="/" element={<Navigate to="/home" replace />} />
      </Routes>
    </BrowserRouter>
  );
}