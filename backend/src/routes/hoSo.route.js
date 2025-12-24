const express = require('express');
const router = express.Router();
const hoSoController = require('../controllers/hoSo.controller');
const authMiddleware = require('../middlewares/auth.middleware');

router.use(authMiddleware); // Require auth for all routes

router.get('/', hoSoController.getAll);
router.get('/:id', hoSoController.getById);
router.post('/', hoSoController.create);
router.put('/:id/status', hoSoController.updateStatus);

module.exports = router;