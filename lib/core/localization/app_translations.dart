import 'language_provider.dart';

class AppTranslations {
  static final Map<String, Map<AppLanguage, String>> _translations = {
    // General
    'app_name': {
      AppLanguage.french: 'Éloquence',
      AppLanguage.english: 'Eloquence',
    },
    
    // Home Page
    'word_of_the_day': {
      AppLanguage.french: 'Mot du jour',
      AppLanguage.english: 'Word of the day',
    },
    
    // Word Types
    'noun': {
      AppLanguage.french: 'Nom',
      AppLanguage.english: 'Noun',
    },
    'adj': {
      AppLanguage.french: 'Adj',
      AppLanguage.english: 'Adj',
    },
    'verb': {
      AppLanguage.french: 'Verbe',
      AppLanguage.english: 'Verb',
    },
    
    // Navigation
    'home': {
      AppLanguage.french: 'Accueil',
      AppLanguage.english: 'Home',
    },
    'favorites': {
      AppLanguage.french: 'Favoris',
      AppLanguage.english: 'Favorites',
    },
    'settings': {
      AppLanguage.french: 'Paramètres',
      AppLanguage.english: 'Settings',
    },
    
    // Settings Page
    'appearance': {
      AppLanguage.french: 'Apparence',
      AppLanguage.english: 'Appearance',
    },
    'dark_theme': {
      AppLanguage.french: 'Thème sombre',
      AppLanguage.english: 'Dark theme',
    },
    'enabled': {
      AppLanguage.french: 'Activé',
      AppLanguage.english: 'Enabled',
    },
    'disabled': {
      AppLanguage.french: 'Désactivé',
      AppLanguage.english: 'Disabled',
    },
    'about': {
      AppLanguage.french: 'À propos',
      AppLanguage.english: 'About',
    },
    'version': {
      AppLanguage.french: 'Version',
      AppLanguage.english: 'Version',
    },
    'developer': {
      AppLanguage.french: 'Développeur',
      AppLanguage.english: 'Developer',
    },
    'language': {
      AppLanguage.french: 'Langue',
      AppLanguage.english: 'Language',
    },
    
    // Favorites Page
    'favorite_words': {
      AppLanguage.french: 'Mots favoris',
      AppLanguage.english: 'Favorite words',
    },
    'error_loading_favorites': {
      AppLanguage.french: 'Erreur lors du chargement des favoris',
      AppLanguage.english: 'Error loading favorites',
    },
    'no_favorites': {
      AppLanguage.french: 'Aucun mot favori',
      AppLanguage.english: 'No favorite words',
    },
    'add_favorites_hint': {
      AppLanguage.french: 'Ajoutez des mots à vos favoris pour les retrouver ici',
      AppLanguage.english: 'Add words to your favorites to find them here',
    },
    
    // Actions
    'listen_pronunciation': {
      AppLanguage.french: 'Écouter la prononciation',
      AppLanguage.english: 'Listen to pronunciation',
    },
    'remove_from_favorites': {
      AppLanguage.french: 'Retirer des favoris',
      AppLanguage.english: 'Remove from favorites',
    },
    
    // Word translations (sample)
    'word_etheree': {
      AppLanguage.french: 'Éthéré',
      AppLanguage.english: 'Ethereal',
    },
    'def_etheree': {
      AppLanguage.french: 'D\'une beauté irréelle, presque céleste',
      AppLanguage.english: 'Of unearthly delicacy and lightness, almost celestial',
    },
    'example_etheree': {
      AppLanguage.french: 'Son regard était d\'une beauté éthérée, comme s\'il appartenait à un rêve.',
      AppLanguage.english: 'Her gaze had an ethereal beauty, as if it belonged to a dream.',
    },
    
    'word_serendipity': {
      AppLanguage.french: 'Sérendipité',
      AppLanguage.english: 'Serendipity',
    },
    'def_serendipity': {
      AppLanguage.french: 'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
      AppLanguage.english: 'The occurrence of finding valuable things not sought for',
    },
    'example_serendipity': {
      AppLanguage.french: 'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
      AppLanguage.english: 'It was by serendipity that he found his calling when getting lost in that museum.',
    },
    
    'word_ineffable': {
      AppLanguage.french: 'Ineffable',
      AppLanguage.english: 'Ineffable',
    },
    'def_ineffable': {
      AppLanguage.french: 'Qui ne peut être exprimé par des paroles tant c\'est intense',
      AppLanguage.english: 'Too great to be expressed in words',
    },
    'example_ineffable': {
      AppLanguage.french: 'Face à ce paysage grandiose, il ressentit une joie ineffable.',
      AppLanguage.english: 'Facing this magnificent landscape, he felt an ineffable joy.',
    },
    
    'word_acrimony': {
      AppLanguage.french: 'Acrimonie',
      AppLanguage.english: 'Acrimony',
    },
    'def_acrimony': {
      AppLanguage.french: 'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
      AppLanguage.english: 'Bitterness or ill feeling that is displayed in speech or behavior',
    },
    'example_acrimony': {
      AppLanguage.french: 'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
      AppLanguage.english: 'He responded with acrimony to the criticisms made against his project.',
    },
    
    'word_quintessence': {
      AppLanguage.french: 'Quintessence',
      AppLanguage.english: 'Quintessence',
    },
    'def_quintessence': {
      AppLanguage.french: 'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
      AppLanguage.english: 'The most perfect embodiment of something',
    },
    'example_quintessence': {
      AppLanguage.french: 'Ce plat représente la quintessence de la cuisine française traditionnelle.',
      AppLanguage.english: 'This dish represents the quintessence of traditional French cuisine.',
    },
  };
  
  static String translate(String key, AppLanguage language) {
    if (_translations.containsKey(key)) {
      return _translations[key]![language] ?? key;
    }
    return key;
  }
}
