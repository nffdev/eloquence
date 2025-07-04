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
    WordTranslation(
      french: Word(
        word: 'Séraphique',
        type: 'Adj',
        definition: 'Qui évoque la pureté, la béatitude des séraphins; d\'une douceur angélique',
        example: 'Son sourire séraphique apaisait instantanément les tensions dans la pièce.',
        language: 'fr',
      ),
      english: Word(
        word: 'Seraphic',
        type: 'Adj',
        definition: 'Characteristic of or resembling a seraph or seraphim; angelic',
        example: 'Her seraphic smile instantly eased the tensions in the room.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Pérennité',
        type: 'Nom',
        definition: 'Caractère de ce qui dure toujours ou très longtemps',
        example: 'La pérennité de cette tradition familiale se transmet depuis des générations.',
        language: 'fr',
      ),
      english: Word(
        word: 'Perpetuity',
        type: 'Noun',
        definition: 'The state or quality of lasting forever',
        example: 'The perpetuity of this family tradition has been passed down for generations.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Mélopée',
        type: 'Nom',
        definition: 'Chant monotone et plaintif; suite de sons répétitifs et mélancoliques',
        example: 'La mélopée du vent dans les arbres berçait doucement les voyageurs épuisés.',
        language: 'fr',
      ),
      english: Word(
        word: 'Dirge',
        type: 'Noun',
        definition: 'A mournful song, piece of music, or sound; a lament',
        example: 'The dirge of the wind through the trees gently lulled the exhausted travelers.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Indicible',
        type: 'Adj',
        definition: 'Qui ne peut être exprimé par des paroles, inexprimable',
        example: 'Une joie indicible l\'envahit lorsqu\'il aperçut enfin sa terre natale à l\'horizon.',
        language: 'fr',
      ),
      english: Word(
        word: 'Unspeakable',
        type: 'Adj',
        definition: 'Too extreme to be expressed in words',
        example: 'An unspeakable joy overwhelmed him when he finally glimpsed his homeland on the horizon.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Alacrité',
        type: 'Nom',
        definition: 'Vivacité joyeuse, entrain, enthousiasme',
        example: 'Elle abordait chaque journée avec une alacrité contagieuse qui inspirait son entourage.',
        language: 'fr',
      ),
      english: Word(
        word: 'Alacrity',
        type: 'Noun',
        definition: 'Brisk and cheerful readiness',
        example: 'She approached each day with a contagious alacrity that inspired those around her.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Diapré',
        type: 'Adj',
        definition: 'Qui présente des couleurs variées et chatoyantes',
        example: 'Le ciel diapré du crépuscule offrait un spectacle d\'une beauté saisissante.',
        language: 'fr',
      ),
      english: Word(
        word: 'Dappled',
        type: 'Adj',
        definition: 'Marked with spots or patches of color; variegated',
        example: 'The dappled twilight sky offered a spectacle of striking beauty.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Acuité',
        type: 'Nom',
        definition: 'Caractère de ce qui est aigu, pénétrant; finesse de perception',
        example: 'Son acuité intellectuelle lui permettait de résoudre des problèmes complexes avec une facilité déconcertante.',
        language: 'fr',
      ),
      english: Word(
        word: 'Acuity',
        type: 'Noun',
        definition: 'Sharpness or keenness of thought, vision, or hearing',
        example: 'His intellectual acuity allowed him to solve complex problems with disconcerting ease.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Déliquescent',
        type: 'Adj',
        definition: 'Qui se dissout, se désagrège progressivement; en état de décomposition',
        example: 'L\'atmosphère déliquescente du vieux manoir évoquait la splendeur passée d\'une époque révolue.',
        language: 'fr',
      ),
      english: Word(
        word: 'Deliquescent',
        type: 'Adj',
        definition: 'Becoming liquid, or having a tendency to become liquid; melting away',
        example: 'The deliquescent atmosphere of the old manor evoked the past splendor of a bygone era.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Équanimité',
        type: 'Nom',
        definition: 'Égalité d\'humeur, sérénité face aux événements, bons ou mauvais',
        example: 'Le sage accueillait les nouvelles, bonnes ou mauvaises, avec une parfaite équanimité.',
        language: 'fr',
      ),
      english: Word(
        word: 'Equanimity',
        type: 'Noun',
        definition: 'Mental calmness, composure, and evenness of temper, especially in a difficult situation',
        example: 'The sage received the news, good or bad, with perfect equanimity.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Sempiternel',
        type: 'Adj',
        definition: 'Qui dure toujours, qui se répète sans cesse, éternel',
        example: 'Il reprenait son sempiternelle complainte sur les difficultés de la vie moderne.',
        language: 'fr',
      ),
      english: Word(
        word: 'Sempiternal',
        type: 'Adj',
        definition: 'Eternal and unchanging; everlasting',
        example: 'He resumed his sempiternal complaint about the difficulties of modern life.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Éphémère',
        type: 'Adj',
        definition: 'Qui ne dure qu\'un temps très court, passager, fugitif',
        example: 'La beauté éphémère des fleurs de cerisier rend leur apparition annuelle d\'autant plus précieuse.',
        language: 'fr',
      ),
      english: Word(
        word: 'Ephemeral',
        type: 'Adj',
        definition: 'Lasting for a very short time',
        example: 'The ephemeral beauty of cherry blossoms makes their annual appearance all the more precious.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Limerence',
        type: 'Nom',
        definition: 'État d\'être infatué ou obsédé par une autre personne',
        example: 'Sa limerence pour elle obscurcissait son jugement et consumait chacune de ses pensées.',
        language: 'fr',
      ),
      english: Word(
        word: 'Limerence',
        type: 'Noun',
        definition: 'The state of being infatuated or obsessed with another person',
        example: 'His limerence for her clouded his judgment and consumed his every thought.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Pétrichor',
        type: 'Nom',
        definition: 'L\'odeur agréable qui accompagne la première pluie après une longue période de temps sec',
        example: 'Après des mois de sécheresse, le pétrichor s\'élevant de la terre humide était enivrant.',
        language: 'fr',
      ),
      english: Word(
        word: 'Petrichor',
        type: 'Noun',
        definition: 'The pleasant smell that accompanies the first rain after a long period of dry weather',
        example: 'After months of drought, the petrichor rising from the damp earth was intoxicating.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Sonder',
        type: 'Verbe',
        definition: 'La prise de conscience que chaque passant vit une vie aussi intense et complexe que la vôtre',
        example: 'En marchant dans les rues bondées de la ville, elle fut submergée par un sentiment de sonder.',
        language: 'fr',
      ),
      english: Word(
        word: 'Sonder',
        type: 'Verb',
        definition: 'The realization that each random passerby is living a life as vivid and complex as your own',
        example: 'Walking through the crowded city streets, she was overcome with a feeling of sonder.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Alcyon',
        type: 'Adj',
        definition: 'Qui désigne une période du passé idylliquement heureuse et paisible',
        example: 'Il se remémorait souvent ces jours alcyoniens de sa jeunesse passés au bord de la mer.',
        language: 'fr',
      ),
      english: Word(
        word: 'Halcyon',
        type: 'Adj',
        definition: 'Denoting a period of time in the past that was idyllically happy and peaceful',
        example: 'He often reminisced about those halcyon days of his youth spent by the seaside.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Vellichor',
        type: 'Nom',
        definition: 'L\'étrange mélancolie des librairies d\'occasion',
        example: 'Le vellichor de l\'ancienne librairie le transportait vers d\'innombrables autres mondes et époques.',
        language: 'fr',
      ),
      english: Word(
        word: 'Vellichor',
        type: 'Noun',
        definition: 'The strange wistfulness of used bookstores',
        example: 'The vellichor of the ancient bookshop transported him to countless other worlds and times.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Éloquent',
        type: 'Adj',
        definition: 'Qui s\'exprime avec aisance et de façon persuasive',
        example: 'Son discours éloquent a ému l\'auditoire aux larmes et les a inspirés à agir.',
        language: 'fr',
      ),
      english: Word(
        word: 'Eloquent',
        type: 'Adj',
        definition: 'Fluent or persuasive in speaking or writing',
        example: 'Her eloquent speech moved the audience to tears and inspired them to action.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Lumineux',
        type: 'Adj',
        definition: 'Qui émet ou réfléchit la lumière; brillant ou éclatant',
        example: 'Son sourire lumineux illuminait toute la pièce quand elle entrait.',
        language: 'fr',
      ),
      english: Word(
        word: 'Luminous',
        type: 'Adj',
        definition: 'Full of or shedding light; bright or shining',
        example: 'Her luminous smile lit up the entire room when she entered.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Mélodieux',
        type: 'Adj',
        definition: 'Qui produit une succession agréable de sons; harmonieux',
        example: 'Les tons mélodieux du violoncelle remplissaient la salle de concert de chaleur.',
        language: 'fr',
      ),
      english: Word(
        word: 'Mellifluous',
        type: 'Adj',
        definition: 'Sweet or musical; pleasant to hear',
        example: 'The mellifluous tones of the cello filled the concert hall with warmth.',
        language: 'en',
      ),
    ),
    WordTranslation(
      french: Word(
        word: 'Sérénité',
        type: 'Nom',
        definition: 'État de calme, de paix et de tranquillité',
        example: 'La sérénité du lac de montagne à l\'aube restaurait son sentiment de paix intérieure.',
        language: 'fr',
      ),
      english: Word(
        word: 'Serenity',
        type: 'Noun',
        definition: 'The state of being calm, peaceful, and untroubled',
        example: 'The serenity of the mountain lake at dawn restored his sense of inner peace.',
        language: 'en',
      ),
    ),
  ];
}