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
        false,
        'fr'
      ),
      new Word(
        'Sérendipité',
        'Nom',
        'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
        'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
        false,
        'fr'
      ),
      new Word(
        'Ineffable',
        'Adj',
        'Qui ne peut être exprimé par des paroles tant c\'est intense',
        'Face à ce paysage grandiose, il ressentit une joie ineffable.',
        false,
        'fr'
      ),
      new Word(
        'Acrimonie',
        'Nom',
        'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
        'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
        false,
        'fr'
      ),
      new Word(
        'Quintessence',
        'Nom',
        'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
        'Ce plat représente la quintessence de la cuisine française traditionnelle.',
        false,
        'fr'
      ),
      new Word(
        'Pérégrin',
        'Adj',
        'Qui voyage, qui vient de loin, étranger ou voyageur',
        'Cet oiseau pérégrin avait parcouru des milliers de kilomètres avant d\'arriver sur nos côtes.',
        false,
        'fr'
      ),
      new Word(
        'Sibyllin',
        'Adj',
        'Obscur, énigmatique, difficile à comprendre mais semblant cacher un sens profond',
        'Ses réponses sibyllines ne m\'ont pas permis de comprendre ses véritables intentions.',
        false,
        'fr'
      ),
      new Word(
        'Palimpseste',
        'Nom',
        'Manuscrit dont on a effacé le texte primitif pour y écrire un nouveau texte; par extension, œuvre qui se superpose à une autre en la laissant transparaître',
        'Sa dernière œuvre est un palimpseste littéraire où l\'on reconnaît l\'influence de plusieurs auteurs classiques.',
        false,
        'fr'
      ),
      new Word(
        'Apophtegme',
        'Nom',
        'Parole mémorable ayant valeur de maxime, sentence exprimant une vérité générale',
        'Il terminait toujours ses discours par un apophtegme qui résumait parfaitement sa pensée.',
        false,
        'fr'
      ),
      new Word(
        'Conciliabule',
        'Nom',
        'Entretien secret entre plusieurs personnes, généralement pour préparer un complot ou une action commune',
        'Après une heure de conciliabule dans le bureau du directeur, la décision fut annoncée à l\'ensemble du personnel.',
        false,
        'fr'
      ),
      
      new Word(
        'Ethereal',
        'Adj',
        'Extremely delicate and light in a way that seems too perfect for this world',
        'The ethereal beauty of the mountains at sunrise took her breath away.',
        false,
        'en'
      ),
      new Word(
        'Serendipity',
        'Noun',
        'The occurrence and development of events by chance in a happy or beneficial way',
        'It was pure serendipity that he met his future business partner on that flight.',
        false,
        'en'
      ),
      new Word(
        'Ineffable',
        'Adj',
        'Too great or extreme to be expressed or described in words',
        'The ineffable joy of becoming a parent for the first time cannot be adequately described.',
        false,
        'en'
      ),
      new Word(
        'Acrimony',
        'Noun',
        'Bitterness or ill feeling',
        'The divorce was filled with acrimony, making it difficult for them to co-parent effectively.',
        false,
        'en'
      ),
      new Word(
        'Quintessence',
        'Noun',
        'The most perfect or typical example of a quality or class',
        'This dish is the quintessence of traditional Italian cooking.',
        false,
        'en'
      ),
      new Word(
        'Peregrination',
        'Noun',
        'A journey, especially a long or meandering one',
        'His peregrination across Europe lasted three months and took him through twelve different countries.',
        false,
        'en'
      ),
      new Word(
        'Perspicacious',
        'Adj',
        'Having a ready insight into and understanding of things',
        'Her perspicacious comments during the meeting revealed she had already anticipated the problem.',
        false,
        'en'
      ),
      new Word(
        'Mellifluous',
        'Adj',
        'Sweet or musical; pleasant to hear',
        'The speaker\'s mellifluous voice made even the most mundane topic seem fascinating.',
        false,
        'en'
      ),
      new Word(
        'Obfuscate',
        'Verb',
        'To make obscure, unclear, or unintelligible',
        'The politician tried to obfuscate the issue by using complex technical jargon.',
        false,
        'en'
      ),
      new Word(
        'Supercilious',
        'Adj',
        'Behaving or looking as though one is superior to others',
        'The supercilious waiter looked down his nose at customers who didn\'t know about wine.',
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
    const filteredWords = this.words.filter(word => word.language === language);
    
    if (filteredWords.length === 0 && language !== 'fr') {
      return this.getWordOfTheDay('fr');
    }
    
    if (filteredWords.length === 0) {
      return this.words[0];
    }
    
    const random = Math.floor(Math.random() * filteredWords.length);
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
