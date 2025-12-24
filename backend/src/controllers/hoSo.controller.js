const HoSo = require('../models/hoSo.model');

async function getAll(req, res) {
  try {
    const hoSos = await HoSo.getAll();
    res.json({ data: hoSos });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

async function getById(req, res) {
  try {
    const { id } = req.params;
    const hoSo = await HoSo.getById(id);
    if (!hoSo) return res.status(404).json({ error: 'not_found' });
    res.json({ data: hoSo });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

async function create(req, res) {
  try {
    const hoSoData = req.body;
    const hoSo = await HoSo.create(hoSoData);
    res.status(201).json({ data: hoSo });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

async function updateStatus(req, res) {
  try {
    const { id } = req.params;
    const { trangThaiId } = req.body;
    const hoSo = await HoSo.updateStatus(id, trangThaiId);
    res.json({ data: hoSo });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'internal_error' });
  }
}

module.exports = { getAll, getById, create, updateStatus };