import { create } from 'zustand';
import { persist } from 'zustand/middleware';

const useAuthStore = create(
  persist(
    (set, get) => ({
      user: null,
      token: null,
      role: null,
      isAuthenticated: false,

      login: (userData) => {
        const { token, user } = userData;
        set({
          user,
          token,
          role: user.role,
          isAuthenticated: true,
        });
        localStorage.setItem('token', token);
      },

      logout: () => {
        set({
          user: null,
          token: null,
          role: null,
          isAuthenticated: false,
        });
        localStorage.removeItem('token');
      },

      setUser: (user) => {
        set({ user, role: user.role });
      },

      checkAuth: async () => {
        const token = get().token || localStorage.getItem('token');
        if (!token) return false;

        try {
          // Call API to verify token and get user info
          const response = await fetch('/api/auth/me', {
            headers: {
              'Authorization': `Bearer ${token}`,
            },
          });

          if (response.ok) {
            const userData = await response.json();
            set({
              user: userData.user,
              token,
              role: userData.user.role,
              isAuthenticated: true,
            });
            return true;
          } else {
            get().logout();
            return false;
          }
        } catch (error) {
          console.error('Auth check failed:', error);
          get().logout();
          return false;
        }
      },
    }),
    {
      name: 'auth-storage',
      partialize: (state) => ({
        user: state.user,
        token: state.token,
        role: state.role,
        isAuthenticated: state.isAuthenticated,
      }),
    }
  )
);

export default useAuthStore;