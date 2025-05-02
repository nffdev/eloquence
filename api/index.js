const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const wordRoutes = require('./routes/wordRoutes');

const app = express();
const PORT = process.env.PORT || 8080;

// Middleware
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

// Main route
app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to the API Eloquence',
    version: '1.0.0',
    endpoints: {
      words: '/api/words',
      wordOfTheDay: '/api/words/today',
      wordByName: '/api/words/:name'
    }
  });
});

// Routes
app.use('/api/words', wordRoutes);

app.use((req, res, next) => {
  const error = new Error('Route not found');
  error.status = 404;
  next(error);
});

app.use((error, req, res, next) => {
  res.status(error.status || 500).json({
    success: false,
    error: error.message || 'Server error'
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

module.exports = app;
