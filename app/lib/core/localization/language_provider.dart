import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../features/word_of_the_day/application/word_provider.dart';

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
  
  Future<void> setLanguage(AppLanguage language, {BuildContext? context}) async {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_languagePreferenceKey, language.index);
      
      if (context != null) {
        try {
          final wordProvider = Provider.of<WordProvider>(context, listen: false);
          final code = language == AppLanguage.french ? 'fr' : 'en';
          wordProvider.setLanguage(code);
          debugPrint('Language changed to $code, notified WordProvider to reload word');
        } catch (e) {
          debugPrint('Error notifying WordProvider of language change: $e');
        }
      }
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
