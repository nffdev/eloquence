import '../../features/word_of_the_day/domain/models/word.dart';

class WordConstants {
  static final List<Word> fallbackWords = [
    Word(
      word: 'Éthéré',
      type: 'Adj',
      definition: 'D\'une beauté irréelle, presque céleste',
      example: 'Son regard était d\'une beauté éthérée, comme s\'il appartenait à un rêve.',
      date: '2023-04-06',
      language: 'fr',
    ),
    Word(
      word: 'Sérendipité',
      type: 'Nom',
      definition: 'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
      example: 'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
      date: '2023-04-07',
      language: 'fr',
    ),
    Word(
      word: 'Ineffable',
      type: 'Adj',
      definition: 'Qui ne peut être exprimé par des paroles tant c\'est intense',
      example: 'Face à ce paysage grandiose, il ressentit une joie ineffable.',
      date: '2023-04-08',
      language: 'fr',
    ),
    Word(
      word: 'Acrimonie',
      type: 'Nom',
      definition: 'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
      example: 'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
      date: '2023-04-09',
      language: 'fr',
    ),
    Word(
      word: 'Quintessence',
      type: 'Nom',
      definition: 'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
      example: 'Ce plat représente la quintessence de la cuisine française traditionnelle.',
      date: '2023-04-10',
      language: 'fr',
    ),
    
    Word(
      word: 'Ethereal',
      type: 'Adj',
      definition: 'Extremely delicate and light in a way that seems too perfect for this world',
      example: 'The ethereal beauty of the mountains at sunrise took her breath away.',
      date: '2023-04-06',
      language: 'en',
    ),
    Word(
      word: 'Serendipity',
      type: 'Noun',
      definition: 'The occurrence and development of events by chance in a happy or beneficial way',
      example: 'It was pure serendipity that he met his future business partner on that flight.',
      date: '2023-04-07',
      language: 'en',
    ),
    Word(
      word: 'Ineffable',
      type: 'Adj',
      definition: 'Too great or extreme to be expressed or described in words',
      example: 'The ineffable joy of becoming a parent for the first time cannot be adequately described.',
      date: '2023-04-08',
      language: 'en',
    ),
    Word(
      word: 'Acrimony',
      type: 'Noun',
      definition: 'Bitterness or ill feeling',
      example: 'The divorce was filled with acrimony, making it difficult for them to co-parent effectively.',
      date: '2023-04-09',
      language: 'en',
    ),
    Word(
      word: 'Quintessence',
      type: 'Noun',
      definition: 'The most perfect or typical example of a quality or class',
      example: 'This dish is the quintessence of traditional Italian cooking.',
      date: '2023-04-10',
      language: 'en',
    ),
  ];
}
