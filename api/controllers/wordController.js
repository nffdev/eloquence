const wordRepository = require('../data/wordRepository');
const Word = require('../models/Word');

/**
 * Controller for word-related operations
 */
const wordController = {
  /**
   * Get all words
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   */
  getAllWords: (req, res) => {
    try {
      const words = wordRepository.getAllWords();
      res.status(200).json({
        success: true,
        count: words.length,
        data: words
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Error while getting words'
      });
    }
  },

  /**
   * Get word of the day
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   */
  getWordOfTheDay: (req, res) => {
    try {
      const word = wordRepository.getWordOfTheDay();
      res.status(200).json({
        success: true,
        data: word
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Error while getting word of the day'
      });
    }
  },

  /**
   * Get a word by name
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   */
  getWordByName: (req, res) => {
    try {
      const { name } = req.params;
      const word = wordRepository.getWordByName(name);
      
      if (!word) {
        return res.status(404).json({
          success: false,
          error: `Word '${name}' not found`
        });
      }

      res.status(200).json({
        success: true,
        data: word
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Error while getting word by name'
      });
    }
  },

  /**
   * Create a new word
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   */
  createWord: (req, res) => {
    try {
      const { word, type, definition, example } = req.body;
      
      // Validation
      if (!word || !type || !definition) {
        return res.status(400).json({
          success: false,
          error: 'Please provide the word, type and definition'
        });
      }

      // Check if word already exists
      const existingWord = wordRepository.getWordByName(word);
      if (existingWord) {
        return res.status(400).json({
          success: false,
          error: `Word '${word}' already exists`
        });
      }

      const date = new Date().toISOString().split('T')[0];
      const newWord = new Word(word, type, definition, example || '', date);
      
      const addedWord = wordRepository.addWord(newWord);
      
      res.status(201).json({
        success: true,
        data: addedWord
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Error while creating word'
      });
    }
  },

  /**
   * Update a word
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   */
  updateWord: (req, res) => {
    try {
      const { name } = req.params;
      const { type, definition, example } = req.body;
      
      const updatedWord = wordRepository.updateWord(name, { type, definition, example });
      
      if (!updatedWord) {
        return res.status(404).json({
          success: false,
          error: `Word '${name}' not found`
        });
      }

      res.status(200).json({
        success: true,
        data: updatedWord
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Error while updating word'
      });
    }
  },

  /**
   * Delete a word
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   */
  deleteWord: (req, res) => {
    try {
      const { name } = req.params;
      const deleted = wordRepository.deleteWord(name);
      
      if (!deleted) {
        return res.status(404).json({
          success: false,
          error: `Word '${name}' not found`
        });
      }

      res.status(200).json({
        success: true,
        data: {}
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Error while deleting word'
      });
    }
  }
};

module.exports = wordController;
