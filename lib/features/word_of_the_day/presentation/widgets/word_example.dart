import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';

class WordExample extends StatelessWidget {
  final String example;

  const WordExample({
    super.key,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    
    final exampleTitle = currentLanguage == AppLanguage.french ? 'Exemple :' : 'Example :';
    
    String translatedExample = example;
    
    final firstWord = example.split(' ')[0].toLowerCase();
    final exampleKey = 'example_$firstWord';
    final translatedExampleValue = AppTranslations.translate(exampleKey, currentLanguage);
    
    if (translatedExampleValue != exampleKey) {
      translatedExample = translatedExampleValue;
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
