const Word = require('../models/Word');

/**
 * Repository for managing words data
 */
class WordRepository {
  constructor() {
    this.words = [
      // Mot 1: Éthéré / Ethereal
      new Word(
        'Éthéré',
        'Adj',
        'D\'une beauté irréelle, presque céleste',
        'Son regard était d\'une beauté éthérée, comme s\'il appartenait à un rêve.',
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
      
      // Mot 2: Sérendipité / Serendipity
      new Word(
        'Sérendipité',
        'Nom',
        'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
        'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
        false,
        'fr'
      ),
      new Word(
        'Serendipity',
        'Noun',
        'The occurrence and development of events by chance in a happy or beneficial way',
        'It was pure serendipity that he met his future business partner on that flight.',
        false,
        'en'
      ),
      
      // Mot 3: Ineffable / Ineffable
      new Word(
        'Ineffable',
        'Adj',
        'Qui ne peut être exprimé par des paroles tant c\'est intense',
        'Face à ce paysage grandiose, il ressentit une joie ineffable.',
        false,
        'fr'
      ),
      new Word(
        'Ineffable',
        'Adj',
        'Too great or extreme to be expressed or described in words',
        'The ineffable joy of becoming a parent for the first time cannot be adequately described.',
        false,
        'en'
      ),
      
      // Mot 4: Acrimonie / Acrimony
      new Word(
        'Acrimonie',
        'Nom',
        'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
        'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
        false,
        'fr'
      ),
      new Word(
        'Acrimony',
        'Noun',
        'Bitterness or ill feeling',
        'The divorce was filled with acrimony, making it difficult for them to co-parent effectively.',
        false,
        'en'
      ),
      
      // Mot 5: Quintessence / Quintessence
      new Word(
        'Quintessence',
        'Nom',
        'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
        'Ce plat représente la quintessence de la cuisine française traditionnelle.',
        false,
        'fr'
      ),
      new Word(
        'Quintessence',
        'Noun',
        'The most perfect or typical example of a quality or class',
        'This dish is the quintessence of traditional Italian cooking.',
        false,
        'en'
      ),
      
      // Mot 6: Pérégrin / Peregrine
      new Word(
        'Pérégrin',
        'Adj',
        'Qui voyage, qui vient de loin, étranger ou voyageur',
        'Cet oiseau pérégrin avait parcouru des milliers de kilomètres avant d\'arriver sur nos côtes.',
        false,
        'fr'
      ),
      new Word(
        'Peregrine',
        'Adj',
        'Traveling or migrating; foreign',
        'This peregrine bird had traveled thousands of kilometers before arriving on our shores.',
        false,
        'en'
      ),
      
      // Mot 7: Sibyllin / Sibylline
      new Word(
        'Sibyllin',
        'Adj',
        'Obscur, énigmatique, difficile à comprendre mais semblant cacher un sens profond',
        'Ses réponses sibyllines ne m\'ont pas permis de comprendre ses véritables intentions.',
        false,
        'fr'
      ),
      new Word(
        'Sibylline',
        'Adj',
        'Mysterious, enigmatic, difficult to understand',
        'His sibylline words left everyone perplexed.',
        false,
        'en'
      ),
      
      // Mot 8: Palimpseste / Palimpsest
      new Word(
        'Palimpseste',
        'Nom',
        'Manuscrit dont on a effacé le texte primitif pour y écrire un nouveau texte; par extension, œuvre qui se superpose à une autre en la laissant transparaître',
        'Sa dernière œuvre est un palimpseste littéraire où l\'on reconnaît l\'influence de plusieurs auteurs classiques.',
        false,
        'fr'
      ),
      new Word(
        'Palimpsest',
        'Noun',
        'A manuscript on which the original writing has been effaced to make room for later writing',
        'This palimpsest reveals traces of an ancient text beneath the modern writing.',
        false,
        'en'
      ),
      
      // Mot 9: Apophtegme / Apophthegm
      new Word(
        'Apophtegme',
        'Nom',
        'Parole mémorable ayant valeur de maxime, sentence exprimant une vérité générale',
        'Il terminait toujours ses discours par un apophtegme qui résumait parfaitement sa pensée.',
        false,
        'fr'
      ),
      new Word(
        'Apophthegm',
        'Noun',
        'A terse saying embodying a general truth or astute observation',
        'This apophthegm by Socrates has remained engraved in memory.',
        false,
        'en'
      ),
      
      // Mot 10: Conciliabule / Conciliabule
      new Word(
        'Conciliabule',
        'Nom',
        'Entretien secret entre plusieurs personnes, généralement pour préparer un complot ou une action commune',
        'Après une heure de conciliabule dans le bureau du directeur, la décision fut annoncée à l\'ensemble du personnel.',
        false,
        'fr'
      ),
      new Word(
        'Conciliabule',
        'Noun',
        'A secret or private meeting, especially one with a sinister purpose',
        'They were holding a conciliabule in the corner of the room.',
        false,
        'en'
      ),
      // Mot 11: Séraphique / Seraphic
      new Word(
        'Séraphique',
        'Adj',
        'Qui évoque la pureté, la béatitude des séraphins; d\'une douceur angélique',
        'Son sourire séraphique apaisait instantanément les tensions dans la pièce.',
        false,
        'fr'
      ),
      new Word(
        'Seraphic',
        'Adj',
        'Characteristic of or resembling a seraph or seraphim; angelic',
        'Her seraphic smile instantly eased the tensions in the room.',
        false,
        'en'
      ),
      
      // Mot 12: Pérennité / Perpetuity
      new Word(
        'Pérennité',
        'Nom',
        'Caractère de ce qui dure toujours ou très longtemps',
        'La pérennité de cette tradition familiale se transmet depuis des générations.',
        false,
        'fr'
      ),
      new Word(
        'Perpetuity',
        'Noun',
        'The state or quality of lasting forever',
        'The perpetuity of this family tradition has been passed down for generations.',
        false,
        'en'
      ),
      
      // Mot 13: Mélopée / Dirge
      new Word(
        'Mélopée',
        'Nom',
        'Chant monotone et plaintif; suite de sons répétitifs et mélancoliques',
        'La mélopée du vent dans les arbres berçait doucement les voyageurs épuisés.',
        false,
        'fr'
      ),
      new Word(
        'Dirge',
        'Noun',
        'A mournful song, piece of music, or sound; a lament',
        'The dirge of the wind through the trees gently lulled the exhausted travelers.',
        false,
        'en'
      ),
      
      // Mot 14: Indicible / Unspeakable
      new Word(
        'Indicible',
        'Adj',
        'Qui ne peut être exprimé par des paroles, inexprimable',
        'Une joie indicible l\'envahit lorsqu\'il aperçut enfin sa terre natale à l\'horizon.',
        false,
        'fr'
      ),
      new Word(
        'Unspeakable',
        'Adj',
        'Too extreme to be expressed in words',
        'An unspeakable joy overwhelmed him when he finally glimpsed his homeland on the horizon.',
        false,
        'en'
      ),
      
      // Mot 15: Alacrité / Alacrity
      new Word(
        'Alacrité',
        'Nom',
        'Vivacité joyeuse, entrain, enthousiasme',
        'Elle abordait chaque journée avec une alacrité contagieuse qui inspirait son entourage.',
        false,
        'fr'
      ),
      new Word(
        'Alacrity',
        'Noun',
        'Brisk and cheerful readiness',
        'She approached each day with a contagious alacrity that inspired those around her.',
        false,
        'en'
      ),
      
      // Mot 16: Diapré / Dappled
      new Word(
        'Diapré',
        'Adj',
        'Qui présente des couleurs variées et chatoyantes',
        'Le ciel diapré du crépuscule offrait un spectacle d\'une beauté saisissante.',
        false,
        'fr'
      ),
      new Word(
        'Dappled',
        'Adj',
        'Marked with spots or patches of color; variegated',
        'The dappled twilight sky offered a spectacle of striking beauty.',
        false,
        'en'
      ),
      
      // Mot 17: Acuité / Acuity
      new Word(
        'Acuité',
        'Nom',
        'Caractère de ce qui est aigu, pénétrant; finesse de perception',
        'Son acuité intellectuelle lui permettait de résoudre des problèmes complexes avec une facilité déconcertante.',
        false,
        'fr'
      ),
      new Word(
        'Acuity',
        'Noun',
        'Sharpness or keenness of thought, vision, or hearing',
        'His intellectual acuity allowed him to solve complex problems with disconcerting ease.',
        false,
        'en'
      ),
      
      // Mot 18: Déliquescent / Deliquescent
      new Word(
        'Déliquescent',
        'Adj',
        'Qui se dissout, se désagrège progressivement; en état de décomposition',
        'L\'atmosphère déliquescente du vieux manoir évoquait la splendeur passée d\'une époque révolue.',
        false,
        'fr'
      ),
      new Word(
        'Deliquescent',
        'Adj',
        'Becoming liquid, or having a tendency to become liquid; melting away',
        'The deliquescent atmosphere of the old manor evoked the past splendor of a bygone era.',
        false,
        'en'
      ),
      
      // Mot 19: Équanimité / Equanimity
      new Word(
        'Équanimité',
        'Nom',
        'Égalité d\'humeur, sérénité face aux événements, bons ou mauvais',
        'Le sage accueillait les nouvelles, bonnes ou mauvaises, avec une parfaite équanimité.',
        false,
        'fr'
      ),
      new Word(
        'Equanimity',
        'Noun',
        'Mental calmness, composure, and evenness of temper, especially in a difficult situation',
        'The sage received the news, good or bad, with perfect equanimity.',
        false,
        'en'
      ),
      
      // Mot 20: Sempiternel / Sempiternal
      new Word(
        'Sempiternel',
        'Adj',
        'Qui dure toujours, qui se répète sans cesse, éternel',
        'Il reprenait son sempiternelle complainte sur les difficultés de la vie moderne.',
        false,
        'fr'
      ),
      new Word(
        'Sempiternal',
        'Adj',
        'Eternal and unchanging; everlasting',
        'He resumed his sempiternal complaint about the difficulties of modern life.',
        false,
        'en'
      ),
      
      // Mot 21: Éphémère / Ephemeral
      new Word(
        'Éphémère',
        'Adj',
        'Qui ne dure qu\'un temps très court, passager, fugitif',
        'La beauté éphémère des fleurs de cerisier rend leur apparition annuelle d\'autant plus précieuse.',
        false,
        'fr'
      ),
      new Word(
        'Ephemeral',
        'Adj',
        'Lasting for a very short time',
        'The ephemeral beauty of cherry blossoms makes their annual appearance all the more precious.',
        false,
        'en'
      ),
      
      // Mot 22: Limerence / Limerence
      new Word(
        'Limerence',
        'Nom',
        'État d\'être infatué ou obsédé par une autre personne',
        'Sa limerence pour elle obscurcissait son jugement et consumait chacune de ses pensées.',
        false,
        'fr'
      ),
      new Word(
        'Limerence',
        'Noun',
        'The state of being infatuated or obsessed with another person',
        'His limerence for her clouded his judgment and consumed his every thought.',
        false,
        'en'
      ),
      
      // Mot 23: Pétrichor / Petrichor
      new Word(
        'Pétrichor',
        'Nom',
        'L\'odeur agréable qui accompagne la première pluie après une longue période de temps sec',
        'Après des mois de sécheresse, le pétrichor s\'élevant de la terre humide était enivrant.',
        false,
        'fr'
      ),
      new Word(
        'Petrichor',
        'Noun',
        'The pleasant smell that accompanies the first rain after a long period of dry weather',
        'After months of drought, the petrichor rising from the damp earth was intoxicating.',
        false,
        'en'
      ),
      
      // Mot 24: Sonder / Sonder
      new Word(
        'Sonder',
        'Verbe',
        'La prise de conscience que chaque passant vit une vie aussi intense et complexe que la vôtre',
        'En marchant dans les rues bondées de la ville, elle fut submergée par un sentiment de sonder.',
        false,
        'fr'
      ),
      new Word(
        'Sonder',
        'Verb',
        'The realization that each random passerby is living a life as vivid and complex as your own',
        'Walking through the crowded city streets, she was overcome with a feeling of sonder.',
        false,
        'en'
      ),
      
      // Mot 25: Alcyon / Halcyon
      new Word(
        'Alcyon',
        'Adj',
        'Qui désigne une période du passé idylliquement heureuse et paisible',
        'Il se remémorait souvent ces jours alcyoniens de sa jeunesse passés au bord de la mer.',
        false,
        'fr'
      ),
      new Word(
        'Halcyon',
        'Adj',
        'Denoting a period of time in the past that was idyllically happy and peaceful',
        'He often reminisced about those halcyon days of his youth spent by the seaside.',
        false,
        'en'
      ),
      
      // Mot 26: Vellichor / Vellichor
      new Word(
        'Vellichor',
        'Nom',
        'L\'étrange mélancolie des librairies d\'occasion',
        'Le vellichor de l\'ancienne librairie le transportait vers d\'innombrables autres mondes et époques.',
        false,
        'fr'
      ),
      new Word(
        'Vellichor',
        'Noun',
        'The strange wistfulness of used bookstores',
        'The vellichor of the ancient bookshop transported him to countless other worlds and times.',
        false,
        'en'
      ),
      
      // Mot 27: Éloquent / Eloquent
      new Word(
        'Éloquent',
        'Adj',
        'Qui s\'exprime avec aisance et de façon persuasive',
        'Son discours éloquent a ému l\'auditoire aux larmes et les a inspirés à agir.',
        false,
        'fr'
      ),
      new Word(
        'Eloquent',
        'Adj',
        'Fluent or persuasive in speaking or writing',
        'Her eloquent speech moved the audience to tears and inspired them to action.',
        false,
        'en'
      ),
      
      // Mot 28: Lumineux / Luminous
      new Word(
        'Lumineux',
        'Adj',
        'Qui émet ou réfléchit la lumière; brillant ou éclatant',
        'Son sourire lumineux illuminait toute la pièce quand elle entrait.',
        false,
        'fr'
      ),
      new Word(
        'Luminous',
        'Adj',
        'Full of or shedding light; bright or shining',
        'Her luminous smile lit up the entire room when she entered.',
        false,
        'en'
      ),
      
      // Mot 29: Mélodieux / Mellifluous
      new Word(
        'Mélodieux',
        'Adj',
        'Qui produit une succession agréable de sons; harmonieux',
        'Les tons mélodieux du violoncelle remplissaient la salle de concert de chaleur.',
        false,
        'fr'
      ),
      new Word(
        'Mellifluous',
        'Adj',
        'Sweet or musical; pleasant to hear',
        'The mellifluous tones of the cello filled the concert hall with warmth.',
        false,
        'en'
      ),
      
      // Mot 30: Sérénité / Serenity
      new Word(
        'Sérénité',
        'Nom',
        'État de calme, de paix et de tranquillité',
        'La sérénité du lac de montagne à l\'aube restaurait son sentiment de paix intérieure.',
        false,
        'fr'
      ),
      new Word(
        'Serenity',
        'Noun',
        'The state of being calm, peaceful, and untroubled',
        'The serenity of the mountain lake at dawn restored his sense of inner peace.',
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
    const frenchWords = this.words.filter(word => word.language === 'fr');
    
    const today = new Date();
    const dayOfYear = Math.floor((today - new Date(today.getFullYear(), 0, 0)) / (1000 * 60 * 60 * 24));
    
    const frenchWordIndex = dayOfYear % frenchWords.length;
    const frenchWordOfTheDay = frenchWords[frenchWordIndex];
    
    if (language === 'fr') {
      return frenchWordOfTheDay;
    }
    
    const requestedLangWords = this.words.filter(word => word.language === language);
    
    if (requestedLangWords.length === 0) {
      return frenchWordOfTheDay;
    }
    
    // We assume words are defined in the same order for all languages
    // So we use the same index as the French word
    const correspondingWordIndex = frenchWordIndex % requestedLangWords.length;
    
    return requestedLangWords[correspondingWordIndex];
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
