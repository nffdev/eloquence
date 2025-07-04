import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/utils/word_utils.dart';
import '../../domain/models/word.dart';

class WordExample extends StatelessWidget {
  final String example;
  final String word;

  const WordExample({
    super.key,
    required this.example,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    
    final exampleTitle = currentLanguage == AppLanguage.french ? 'Exemple :' : 'Example :';
    
    String translatedExample = example;
    
    final tempWord = Word(
      word: word,
      type: '',
      definition: '',
      example: example,
      language: 'fr',
    );
    
    if (currentLanguage == AppLanguage.english) {
      final translation = WordUtils.getTranslation(tempWord, 'en');
      if (translation != null) {
        translatedExample = translation.example;
      }
    }
    
    return Column(
      children: [
        Text(
          exampleTitle,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          '"$translatedExample"',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
