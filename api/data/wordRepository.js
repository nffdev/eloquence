const Word = require('../models/Word');

/**
 * Repository for managing words data
 */
class WordRepository {
  constructor() {
    this.words = [
      new Word(
        'Éthéré',
        'Adj',
        'D\'une beauté irréelle, presque céleste',
        'Son regard était d\'une beauté éthérée, comme s\'il appartenait à un rêve.',
        '2023-04-06'
      ),
      new Word(
        'Sérendipité',
        'Nom',
        'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
        'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
        '2023-04-07'
      ),
      new Word(
        'Ineffable',
        'Adj',
        'Qui ne peut être exprimé par des paroles tant c\'est intense',
        'Face à ce paysage grandiose, il ressentit une joie ineffable.',
        '2023-04-08'
      ),
      new Word(
        'Acrimonie',
        'Nom',
        'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
        'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
        '2023-04-09'
      ),
      new Word(
        'Quintessence',
        'Nom',
        'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
        'Ce plat représente la quintessence de la cuisine française traditionnelle.',
        '2023-04-10'
      )
    ];
  }

  /**
   * Get all words
   * @returns {Array} Array of Word objects
   */
  getAllWords() {
    return this.words;
  }

  /**
   * Get a word by its name
   * @param {string} wordName - The name of the word to find
   * @returns {Word|null} The found word or null
   */
  getWordByName(wordName) {
    return this.words.find(word => word.word.toLowerCase() === wordName.toLowerCase()) || null;
  }

  /**
   * Get word of the day
   * @returns {Word} A word for today
   */
  getWordOfTheDay() {
    const today = new Date();
    const random = today.getDate() % this.words.length;
    return this.words[random];
  }

  /**
   * Add a new word
   * @param {Word} word - The word to add
   * @returns {Word} The added word
   */
  addWord(word) {
    this.words.push(word);
    return word;
  }

  /**
   * Update a word
   * @param {string} wordName - The name of the word to update
   * @param {Object} updatedData - The updated data
   * @returns {Word|null} The updated word or null if not found
   */
  updateWord(wordName, updatedData) {
    const index = this.words.findIndex(word => word.word.toLowerCase() === wordName.toLowerCase());
    if (index === -1) return null;

    const updatedWord = { ...this.words[index], ...updatedData };
    this.words[index] = Word.fromJSON(updatedWord);
    return this.words[index];
  }

  /**
   * Delete a word
   * @param {string} wordName - The name of the word to delete
   * @returns {boolean} True if deleted, false if not found
   */
  deleteWord(wordName) {
    const initialLength = this.words.length;
    this.words = this.words.filter(word => word.word.toLowerCase() !== wordName.toLowerCase());
    return this.words.length < initialLength;
  }
}

module.exports = new WordRepository();
