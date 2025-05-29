import '../../features/word_of_the_day/domain/models/word.dart';

class WordConstants {
  static final List<Word> fallbackWords = [
    Word(
      word: 'Éthéré',
      type: 'Adj',
      definition: 'D\'une beauté irréelle, presque céleste',
      example: 'Son regard était d\'une beauté éthérée, comme s\'il appartenait à un rêve.',
      date: '2023-04-06',
    ),
    Word(
      word: 'Sérendipité',
      type: 'Nom',
      definition: 'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
      example: 'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
      date: '2023-04-07',
    ),
    Word(
      word: 'Ineffable',
      type: 'Adj',
      definition: 'Qui ne peut être exprimé par des paroles tant c\'est intense',
      example: 'Face à ce paysage grandiose, il ressentit une joie ineffable.',
      date: '2023-04-08',
    ),
    Word(
      word: 'Acrimonie',
      type: 'Nom',
      definition: 'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
      example: 'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
      date: '2023-04-09',
    ),
    Word(
      word: 'Quintessence',
      type: 'Nom',
      definition: 'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
      example: 'Ce plat représente la quintessence de la cuisine française traditionnelle.',
      date: '2023-04-10',
    ),
  ];
}
