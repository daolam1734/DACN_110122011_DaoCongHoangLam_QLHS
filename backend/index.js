require('dotenv').config();
const express = require('express');
const app = express();

const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({ status: 'ok', envPort: process.env.PORT || null });
});

app.listen(port, () => {
  console.log(`Backend server listening on port ${port}`);
});
