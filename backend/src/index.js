require('dotenv').config();
const express = require('express');
const app = express();
const path = require('path');

const port = process.env.PORT || 3000;

// built-in middleware
app.use(express.json());

// simple health
app.get('/', (req, res) => {
  res.json({ status: 'ok', envPort: process.env.PORT || null });
});

// auth routes
app.use('/auth', require(path.join(__dirname, 'routes', 'auth')));

app.listen(port, () => {
  console.log(`Backend server listening on port ${port}`);
});
