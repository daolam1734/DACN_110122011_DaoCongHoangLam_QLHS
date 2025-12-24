// workflow.service.js - Workflow business logic
const QuyTrinh = require('../models/quyTrinh.model');

async function processNextStep(hoSoId, userId, action) {
  // Implement workflow logic here
  // For example, check current status, user role, move to next step
  // This is placeholder
  return { success: true, nextStatus: 'next' };
}

module.exports = { processNextStep };