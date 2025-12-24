// role.middleware.js - role-based authorization middleware

module.exports = function authorizeRoles(...allowedRoles) {
  return (req, res, next) => {
    const userPayload = req.user || {};
    const userRoles = userPayload.roles || (req.userDetails && req.userDetails.roles) || [];

    if (!userPayload || !userPayload.sub) return res.status(401).json({ error: 'unauthenticated' });

    // if no roles required, allow
    if (!allowedRoles || allowedRoles.length === 0) return next();

    // check intersection
    const has = userRoles.some(r => allowedRoles.includes(r));
    if (!has) return res.status(403).json({ error: 'forbidden' });
    return next();
  };
};