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
        '2023-04-06',
        false,
        'fr'
      ),
      new Word(
        'Sérendipité',
        'Nom',
        'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
        'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
        '2023-04-07',
        false,
        'fr'
      ),
      new Word(
        'Ineffable',
        'Adj',
        'Qui ne peut être exprimé par des paroles tant c\'est intense',
        'Face à ce paysage grandiose, il ressentit une joie ineffable.',
        '2023-04-08',
        false,
        'fr'
      ),
      new Word(
        'Acrimonie',
        'Nom',
        'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
        'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
        '2023-04-09',
        false,
        'fr'
      ),
      new Word(
        'Quintessence',
        'Nom',
        'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
        'Ce plat représente la quintessence de la cuisine française traditionnelle.',
        '2023-04-10',
        false,
        'fr'
      ),
      
      new Word(
        'Ethereal',
        'Adj',
        'Extremely delicate and light in a way that seems too perfect for this world',
        'The ethereal beauty of the mountains at sunrise took her breath away.',
        '2023-04-06',
        false,
        'en'
      ),
      new Word(
        'Serendipity',
        'Noun',
        'The occurrence and development of events by chance in a happy or beneficial way',
        'It was pure serendipity that he met his future business partner on that flight.',
        '2023-04-07',
        false,
        'en'
      ),
      new Word(
        'Ineffable',
        'Adj',
        'Too great or extreme to be expressed or described in words',
        'The ineffable joy of becoming a parent for the first time cannot be adequately described.',
        '2023-04-08',
        false,
        'en'
      ),
      new Word(
        'Acrimony',
        'Noun',
        'Bitterness or ill feeling',
        'The divorce was filled with acrimony, making it difficult for them to co-parent effectively.',
        '2023-04-09',
        false,
        'en'
      ),
      new Word(
        'Quintessence',
        'Noun',
        'The most perfect or typical example of a quality or class',
        'This dish is the quintessence of traditional Italian cooking.',
        '2023-04-10',
        false,
        'en'
      )
    ];
  }

  /**
   * Get all words
   * @param {string} language - Language code (fr, en)
   * @returns {Array} Array of Word objects filtered by language
   */
  getAllWords(language) {
    if (!language) {
      return this.words;
    }
    
    return this.words.filter(word => word.language === language);
  }

  /**
   * Get a word by its name
   * @param {string} wordName - The name of the word to find
   * @param {string} language - Language code (fr, en)
   * @returns {Word|null} The found word or null
   */
  getWordByName(wordName, language) {
    if (language) {
      return this.words.find(
        word => word.word.toLowerCase() === wordName.toLowerCase() && word.language === language
      ) || null;
    }
    
    return this.words.find(word => word.word.toLowerCase() === wordName.toLowerCase()) || null;
  }

  /**
   * Get word of the day
   * @param {string} language - Language code (fr, en)
   * @returns {Word} A word for today in the specified language
   */
  getWordOfTheDay(language = 'fr') {
    const today = new Date();
    
    const filteredWords = this.words.filter(word => word.language === language);
    
    if (filteredWords.length === 0 && language !== 'fr') {
      return this.getWordOfTheDay('fr');
    }
    
    if (filteredWords.length === 0) {
      return this.words[0];
    }
    
    const random = today.getDate() % filteredWords.length;
    return filteredWords[random];
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
