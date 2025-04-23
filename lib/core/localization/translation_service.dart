import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'app_translations.dart';

class TranslationService {
  static String translate(BuildContext context, String key) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return AppTranslations.translate(key, languageProvider.currentLanguage);
  }
}

extension TranslationExtension on BuildContext {
  String tr(String key) {
    return TranslationService.translate(this, key);
  }
}
