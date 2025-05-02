const express = require('express');
const wordController = require('../controllers/wordController');

const router = express.Router();

/**
 * @route   GET /api/words
 * @desc    Get all words
 * @access  Public
 */
router.get('/', wordController.getAllWords);

/**
 * @route   GET /api/words/today
 * @desc    Get word of the day
 * @access  Public
 */
router.get('/today', wordController.getWordOfTheDay);

/**
 * @route   GET /api/words/:name
 * @desc    Get a word by name
 * @access  Public
 */
router.get('/:name', wordController.getWordByName);

/**
 * @route   POST /api/words
 * @desc    Create a new word
 * @access  Public
 */
router.post('/', wordController.createWord);

/**
 * @route   PUT /api/words/:name
 * @desc    Update a word
 * @access  Public
 */
router.put('/:name', wordController.updateWord);

/**
 * @route   DELETE /api/words/:name
 * @desc    Delete a word
 * @access  Public
 */
router.delete('/:name', wordController.deleteWord);

module.exports = router;
