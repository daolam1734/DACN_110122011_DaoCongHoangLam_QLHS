const QuyTrinh = require('../models/quyTrinh.model');

async function getAllQuyTrinh(req, res) {
  try {
    const quyTrinhs = await QuyTrinh.getAll();
    res.json({ data: quyTrinhs });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

async function getQuyTrinhById(req, res) {
  try {
    const { id } = req.params;
    const quyTrinh = await QuyTrinh.getById(id);
    if (!quyTrinh) return res.status(404).json({ error: 'not_found' });
    res.json({ data: quyTrinh });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

async function getBuocXuLy(req, res) {
  try {
    const { id } = req.params;
    const buocXuLy = await QuyTrinh.getBuocXuLy(id);
    res.json({ data: buocXuLy });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

module.exports = { getAllQuyTrinh, getQuyTrinhById, getBuocXuLy };