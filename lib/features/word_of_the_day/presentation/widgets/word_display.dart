import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/word.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';

class WordDisplay extends StatelessWidget {
  final Word word;

  const WordDisplay({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    
    final translatedWordType = AppTranslations.translate(word.type.toLowerCase(), currentLanguage);
    
    String translatedWord = word.word;
    final wordKey = 'word_${word.word.toLowerCase()}';
    final translatedWordValue = AppTranslations.translate(wordKey, currentLanguage);
    if (translatedWordValue != wordKey) {
      translatedWord = translatedWordValue;
    }
    
    String translatedDefinition = word.definition;
    final defKey = 'def_${word.word.toLowerCase()}';
    final translatedDefValue = AppTranslations.translate(defKey, currentLanguage);
    if (translatedDefValue != defKey) {
      translatedDefinition = translatedDefValue;
    }
    
    return Column(
      children: [
        Text(
          '($translatedWordType)',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          '$translatedWord :',
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Text(
          translatedDefinition,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
