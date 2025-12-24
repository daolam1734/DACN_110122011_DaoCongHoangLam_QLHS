// file.service.js - File upload/download logic
const fs = require('fs');
const path = require('path');

const UPLOAD_DIR = path.join(__dirname, '../../uploads');

if (!fs.existsSync(UPLOAD_DIR)) {
  fs.mkdirSync(UPLOAD_DIR, { recursive: true });
}

async function saveFile(file, hoSoId) {
  // Save file to uploads/hoSoId/filename
  const dir = path.join(UPLOAD_DIR, hoSoId.toString());
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const filePath = path.join(dir, file.originalname);
  fs.writeFileSync(filePath, file.buffer);
  return filePath;
}

async function getFilePath(hoSoId, filename) {
  return path.join(UPLOAD_DIR, hoSoId.toString(), filename);
}

module.exports = { saveFile, getFilePath };