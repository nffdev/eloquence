import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage {
  french,
  english,
}

class LanguageProvider extends ChangeNotifier {
  static const String _languagePreferenceKey = 'language_preference';
  
  AppLanguage _currentLanguage = AppLanguage.french;
  AppLanguage get currentLanguage => _currentLanguage;
  
  LanguageProvider() {
    _loadLanguagePreference();
  }
  
  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final languageIndex = prefs.getInt(_languagePreferenceKey);
    if (languageIndex != null) {
      _currentLanguage = AppLanguage.values[languageIndex];
    }
    notifyListeners();
  }
  
  Future<void> setLanguage(AppLanguage language) async {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_languagePreferenceKey, language.index);
    }
  }
  
  String get languageCode {
    switch (_currentLanguage) {
      case AppLanguage.french:
        return 'fr';
      case AppLanguage.english:
        return 'en';
    }
  }
  
  String get languageDisplayName {
    switch (_currentLanguage) {
      case AppLanguage.french:
        return 'FR';
      case AppLanguage.english:
        return 'EN-US';
    }
  }
  
  String get flagCode {
    switch (_currentLanguage) {
      case AppLanguage.french:
        return 'FR';
      case AppLanguage.english:
        return 'US';
    }
  }
}
