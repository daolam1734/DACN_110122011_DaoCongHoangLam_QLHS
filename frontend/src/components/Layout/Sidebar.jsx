import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import useAuthStore from '../../store/auth.store';
import { hasPermission } from '../../utils/role.util';

export default function Sidebar() {
  const location = useLocation();
  const { role } = useAuthStore();

  const menuItems = [
    { path: '/home', label: 'Trang chủ', icon: '🏠', permission: null },
    { path: '/hoso/cua-toi', label: 'Hồ sơ của tôi', icon: '📁', permission: 'view_own_hoso' },
    { path: '/hoso/tao-moi', label: 'Tạo hồ sơ mới', icon: '➕', permission: 'create_hoso' },
    { path: '/xuly/cho-xu-ly', label: 'Hồ sơ chờ xử lý', icon: '⏳', permission: 'approve_hoso' },
    { path: '/xuly/lich-su', label: 'Lịch sử xử lý', icon: '📋', permission: 'view_department_hoso' },
    { path: '/admin/nguoi-dung', label: 'Quản lý người dùng', icon: '👥', permission: 'manage_users' },
    { path: '/admin/nhat-ky', label: 'Nhật ký hệ thống', icon: '📝', permission: 'view_system_logs' },
  ];

  const filteredMenuItems = menuItems.filter(item =>
    !item.permission || hasPermission(role, item.permission)
  );

  return (
    <div className="w-64 bg-white rounded-lg shadow-sm p-6">
      <nav className="space-y-2">
        {filteredMenuItems.map((item) => (
          <Link
            key={item.path}
            to={item.path}
            className={`w-full flex items-center px-4 py-2 text-sm font-medium rounded-md ${
              location.pathname === item.path
                ? 'bg-indigo-100 text-indigo-700'
                : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'
            }`}
          >
            <span className="mr-3">{item.icon}</span>
            {item.label}
          </Link>
        ))}
      </nav>
    </div>
  );
}