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
    'preferences': {
      AppLanguage.french: 'Préférences',
      AppLanguage.english: 'Preferences',
    },
    'preferences_subtitle': {
      AppLanguage.french: 'Thème, langue et autres paramètres',
      AppLanguage.english: 'Theme, language and other settings',
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
    'app_initial': {
      AppLanguage.french: 'É',
      AppLanguage.english: 'E',
    },
    'app_tagline': {
      AppLanguage.french: 'Enrichissez votre vocabulaire',
      AppLanguage.english: 'Enrich your vocabulary',
    },
    'icon': {
      AppLanguage.french: 'Icône',
      AppLanguage.english: 'Icon',
    },
    'app_icon': {
      AppLanguage.french: 'Icône de l\'application',
      AppLanguage.english: 'App icon',
    },
    'choose_icon': {
      AppLanguage.french: 'Choisir une icône',
      AppLanguage.english: 'Choose an icon',
    },
    'default_icon': {
      AppLanguage.french: 'Icône par défaut',
      AppLanguage.english: 'Default icon',
    },
    'classic_icon': {
      AppLanguage.french: 'Icône classique',
      AppLanguage.english: 'Classic icon',
    },
    'dark_icon': {
      AppLanguage.french: 'Icône sombre',
      AppLanguage.english: 'Dark icon',
    },
  };
  
  static String translate(String key, AppLanguage language) {
    if (_translations.containsKey(key)) {
      return _translations[key]![language] ?? key;
    }
    return key;
  }
}
