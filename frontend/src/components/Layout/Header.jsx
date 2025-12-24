import React from 'react';
import { useNavigate } from 'react-router-dom';
import useAuthStore from '../../store/auth.store';
import { getRoleDisplayName } from '../../utils/role.util';

export default function Header() {
  const { user, logout } = useAuthStore();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <header className="bg-white shadow-sm border-b">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center py-4">
          <div className="flex items-center">
            <h1 className="text-2xl font-bold text-gray-900">
              Hệ thống quản lý hồ sơ đi nước ngoài
            </h1>
          </div>
          <div className="flex items-center space-x-4">
            <div className="text-right">
              <span className="text-sm text-gray-700">
                Xin chào, <strong>{user?.username || 'Người dùng'}</strong>
              </span>
              {user?.role && (
                <p className="text-xs text-gray-500">{getRoleDisplayName(user.role)}</p>
              )}
            </div>
            <button
              onClick={handleLogout}
              className="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md text-sm font-medium"
            >
              Đăng xuất
            </button>
          </div>
        </div>
      </div>
    </header>
  );
}