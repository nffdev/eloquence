import '../../../features/word_of_the_day/domain/models/word.dart';

class WordTranslation {
  final Word french;
  final Word english;

  WordTranslation({required this.french, required this.english});
}

class WordConstants {
  static final List<WordTranslation> wordTranslations = [
    WordTranslation(
      french: Word(
        word: 'Éthéré',
        type: 'Adj',
        definition: 'D\'une beauté irréelle, presque céleste',
        example: 'Son regard était d\'une beauté éthérée, comme s\'il appartenait à un rêve.',
        language: 'fr',
      ),
      english: Word(
        word: 'Ethereal',
        type: 'Adj',
        definition: 'Of unearthly, almost celestial beauty',
        example: 'Her gaze was of ethereal beauty, as if it belonged to a dream.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Sérendipité',
        type: 'Nom',
        definition: 'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
        example: 'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
        language: 'fr',
      ),
      english: Word(
        word: 'Serendipity',
        type: 'Noun',
        definition: 'The fact of discovering something by chance while looking for something else',
        example: 'It was by serendipity that he found his calling while getting lost in this museum.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Ineffable',
        type: 'Adj',
        definition: 'Qui ne peut être exprimé par des paroles tant c\'est intense',
        example: 'Face à ce paysage grandiose, il ressentit une joie ineffable.',
        language: 'fr',
      ),
      english: Word(
        word: 'Ineffable',
        type: 'Adj',
        definition: 'Too great or extreme to be expressed in words',
        example: 'Faced with this grandiose landscape, he felt ineffable joy.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Acrimonie',
        type: 'Nom',
        definition: 'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
        example: 'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
        language: 'fr',
      ),
      english: Word(
        word: 'Acrimony',
        type: 'Noun',
        definition: 'Bitterness or harshness in speech, manner, or temper',
        example: 'He responded with acrimony to the criticisms made against his project.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Quintessence',
        type: 'Nom',
        definition: 'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
        example: 'Ce plat représente la quintessence de la cuisine française traditionnelle.',
        language: 'fr',
      ),
      english: Word(
        word: 'Quintessence',
        type: 'Noun',
        definition: 'The most perfect or typical example of a quality or class',
        example: 'This dish represents the quintessence of traditional French cuisine.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Pérégrin',
        type: 'Adj',
        definition: 'Qui voyage, qui vient de loin, étranger ou voyageur',
        example: 'Cet oiseau pérégrin avait parcouru des milliers de kilomètres avant d\'arriver sur nos côtes.',
        language: 'fr',
      ),
      english: Word(
        word: 'Peregrine',
        type: 'Adj',
        definition: 'Traveling or migrating; foreign',
        example: 'This peregrine bird had traveled thousands of kilometers before arriving on our shores.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Sibyllin',
        type: 'Adj',
        definition: 'Mystérieux, énigmatique, difficile à comprendre',
        example: 'Ses paroles sibyllines laissaient tout le monde perplexe.',
        language: 'fr',
      ),
      english: Word(
        word: 'Sibylline',
        type: 'Adj',
        definition: 'Mysterious, enigmatic, difficult to understand',
        example: 'His sibylline words left everyone perplexed.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Palimpseste',
        type: 'Nom',
        definition: 'Manuscrit sur parchemin dont on a effacé la première écriture pour en tracer une nouvelle',
        example: 'Ce palimpseste révèle les traces d\'un texte antique sous l\'écriture moderne.',
        language: 'fr',
      ),
      english: Word(
        word: 'Palimpsest',
        type: 'Noun',
        definition: 'A manuscript on which the original writing has been effaced to make room for later writing',
        example: 'This palimpsest reveals traces of an ancient text beneath the modern writing.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Apophtegme',
        type: 'Nom',
        definition: 'Parole mémorable, sentence exprimée en peu de mots',
        example: 'Cet apophtegme de Socrate est resté gravé dans les mémoires.',
        language: 'fr',
      ),
      english: Word(
        word: 'Apophthegm',
        type: 'Noun',
        definition: 'A terse saying embodying a general truth or astute observation',
        example: 'This apophthegm by Socrates has remained engraved in memory.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Conciliabule',
        type: 'Nom',
        definition: 'Conversation secrète et suspecte entre plusieurs personnes',
        example: 'Ils tenaient un conciliabule dans le coin de la salle.',
        language: 'fr',
      ),
      english: Word(
        word: 'Conciliabule',
        type: 'Noun',
        definition: 'A secret or private meeting, especially one with a sinister purpose',
        example: 'They were holding a conciliabule in the corner of the room.',
        language: 'en',
      ),
    ),
  ];
}