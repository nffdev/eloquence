import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'app_translations.dart';

class TranslationService {
  static String translate(BuildContext context, String key) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return AppTranslations.translate(key, languageProvider.currentLanguage);
  }
  
  static String translateWord(BuildContext context, String word) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final currentLanguage = languageProvider.currentLanguage;
    
    if (currentLanguage == AppLanguage.french) {
      return word;
    }
    
    List<String> possibleKeys = [
      'word_${word.toLowerCase()}',
      'word_${_normalizeKey(word)}',
    ];
    
    for (String key in possibleKeys) {
      final value = AppTranslations.translate(key, currentLanguage);
      if (value != key) {
        return value;
      }
    }
    
    return word; 
  }
  
  static String translateDefinition(BuildContext context, String word, String definition) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final currentLanguage = languageProvider.currentLanguage;
    
    if (currentLanguage == AppLanguage.french) {
      return definition;
    }
    
    List<String> possibleKeys = [
      'def_${word.toLowerCase()}',
      'def_${_normalizeKey(word)}',
    ];
    
    for (String key in possibleKeys) {
      final value = AppTranslations.translate(key, currentLanguage);
      if (value != key) {
        return value;
      }
    }
    
    return definition;
  }
  
  static String translateExample(BuildContext context, String word, String example) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final currentLanguage = languageProvider.currentLanguage;
    
    if (currentLanguage == AppLanguage.french) {
      return example;
    }
    
    List<String> possibleKeys = [
      'example_${word.toLowerCase()}',
      'example_${_normalizeKey(word)}',
    ];
    
    for (String key in possibleKeys) {
      final value = AppTranslations.translate(key, currentLanguage);
      if (value != key) {
        return value;
      }
    }
    
    return example; 
  }
  
  static String _normalizeKey(String input) {
    final Map<String, String> accentMap = {
      'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
      'à': 'a', 'â': 'a', 'ä': 'a',
      'î': 'i', 'ï': 'i',
      'ô': 'o', 'ö': 'o',
      'ù': 'u', 'û': 'u', 'ü': 'u',
      'ç': 'c',
      'É': 'e', 'È': 'e', 'Ê': 'e', 'Ë': 'e',
      'À': 'a', 'Â': 'a', 'Ä': 'a',
      'Î': 'i', 'Ï': 'i',
      'Ô': 'o', 'Ö': 'o',
      'Ù': 'u', 'Û': 'u', 'Ü': 'u',
      'Ç': 'c',
    };
    
    String normalized = input.toLowerCase();
    accentMap.forEach((accent, replacement) {
      normalized = normalized.replaceAll(accent, replacement);
    });
    
    return normalized;
  }
}

extension TranslationExtension on BuildContext {
  String tr(String key) {
    return TranslationService.translate(this, key);
  }
  
  String trWord(String word) {
    return TranslationService.translateWord(this, word);
  }
  
  String trDefinition(String word, String definition) {
    return TranslationService.translateDefinition(this, word, definition);
  }
  
  String trExample(String word, String example) {
    return TranslationService.translateExample(this, word, example);
  }
}
