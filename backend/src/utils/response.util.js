// response.util.js - Standardized response utilities

function success(res, data, message = 'success', status = 200) {
  res.status(status).json({
    success: true,
    message,
    data
  });
}

function error(res, message = 'error', status = 500, code = null) {
  res.status(status).json({
    success: false,
    message,
    code
  });
}

module.exports = { success, error };