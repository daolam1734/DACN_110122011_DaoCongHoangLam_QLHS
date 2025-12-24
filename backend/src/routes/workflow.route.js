const express = require('express');
const router = express.Router();
const workflowController = require('../controllers/workflow.controller');
const authMiddleware = require('../middlewares/auth.middleware');

router.use(authMiddleware);

router.get('/', workflowController.getAllQuyTrinh);
router.get('/:id', workflowController.getQuyTrinhById);
router.get('/:id/buoc', workflowController.getBuocXuLy);

module.exports = router;