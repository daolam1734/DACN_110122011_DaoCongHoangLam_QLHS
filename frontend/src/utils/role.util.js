// Role utilities for the hồ sơ system

export const ROLES = {
  ADMIN: 'admin',
  MANAGER: 'manager',
  USER: 'user',
};

export const ROLE_LABELS = {
  [ROLES.ADMIN]: 'Quản trị viên',
  [ROLES.MANAGER]: 'Quản lý',
  [ROLES.USER]: 'Người dùng',
};

export const ROLE_PERMISSIONS = {
  [ROLES.ADMIN]: [
    'view_all_hoso',
    'edit_all_hoso',
    'manage_users',
    'view_system_logs',
    'approve_hoso',
    'reject_hoso',
  ],
  [ROLES.MANAGER]: [
    'view_department_hoso',
    'edit_department_hoso',
    'approve_hoso',
    'reject_hoso',
    'view_reports',
  ],
  [ROLES.USER]: [
    'view_own_hoso',
    'create_hoso',
    'edit_own_hoso',
  ],
};

export const hasPermission = (userRole, permission) => {
  if (!userRole || !ROLE_PERMISSIONS[userRole]) return false;
  return ROLE_PERMISSIONS[userRole].includes(permission);
};

export const canAccessRoute = (userRole, route) => {
  const routePermissions = {
    '/admin/nguoi-dung': ['manage_users'],
    '/admin/nhat-ky': ['view_system_logs'],
    '/xuly/cho-xu-ly': ['approve_hoso', 'reject_hoso'],
    '/xuly/lich-su': ['view_department_hoso'],
  };

  const requiredPermission = routePermissions[route];
  if (!requiredPermission) return true; // Public route

  return hasPermission(userRole, requiredPermission);
};

export const getRoleDisplayName = (role) => {
  return ROLE_LABELS[role] || role;
};

export const getDefaultRoute = (role) => {
  const roleRoutes = {
    [ROLES.ADMIN]: '/admin/nguoi-dung',
    [ROLES.MANAGER]: '/xuly/cho-xu-ly',
    [ROLES.USER]: '/hoso/cua-toi',
  };

  return roleRoutes[role] || '/hoso/cua-toi';
};