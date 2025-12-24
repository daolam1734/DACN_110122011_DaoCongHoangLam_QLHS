const express = require('express');
const router = express.Router();
const vanBanController = require('../controllers/vanBan.controller');
const authMiddleware = require('../middlewares/auth.middleware');

router.use(authMiddleware);

router.get('/', vanBanController.getAll);
router.post('/', vanBanController.create);

module.exports = router;