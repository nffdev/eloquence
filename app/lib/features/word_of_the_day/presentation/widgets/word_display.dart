import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/word.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';
import '../../../../core/utils/word_utils.dart';

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
    
    String translatedWordType;
    
    String wordType = word.type.toLowerCase();
    
    String typeKey;
    if (wordType == 'nom') {
      typeKey = 'noun';
    } else if (wordType == 'adj') {
      typeKey = 'adj';
    } else if (wordType == 'verbe') {
      typeKey = 'verb';
    } else {
      typeKey = wordType;
    }
    
    translatedWordType = AppTranslations.translate(typeKey, currentLanguage);
    
    String translatedWord;
    String translatedDefinition;
    
    if (currentLanguage == AppLanguage.english) {
      final translation = WordUtils.getTranslation(word, 'en');
      if (translation != null) {
        translatedWord = translation.word;
        translatedDefinition = translation.definition;
      } else {
        translatedWord = word.word;
        translatedDefinition = word.definition;
      }
    } else {
      translatedWord = word.word;
      translatedDefinition = word.definition;
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
