import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import useAuthStore from '../../store/auth.store';
import { getDefaultRoute } from '../../utils/role.util';

export default function Home() {
  const navigate = useNavigate();
  const { user, checkAuth } = useAuthStore();

  useEffect(() => {
    const initAuth = async () => {
      const isAuthenticated = await checkAuth();
      if (!isAuthenticated) {
        navigate('/login', { replace: true });
        return;
      }

      if (user && user.role) {
        const defaultRoute = getDefaultRoute(user.role);
        navigate(defaultRoute, { replace: true });
      }
    };

    initAuth();
  }, [navigate, user, checkAuth]);

  return (
    <div className="min-h-screen flex items-center justify-center">
      <div className="text-center">
        <h2 className="text-xl font-medium">Đang chuyển hướng...</h2>
        <p className="text-sm text-gray-500">Vui lòng chờ trong giây lát.</p>
      </div>
    </div>
  );
}