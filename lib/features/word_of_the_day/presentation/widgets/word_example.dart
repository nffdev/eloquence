import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';
import '../../../../core/localization/translation_service.dart';

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
    
    String translatedExample;
    
    if (currentLanguage == AppLanguage.english) {
      switch (word) {
        case 'Éthéré':
          translatedExample = 'Her gaze had an ethereal beauty, as if it belonged to a dream.';
          break;
        case 'Sérendipité':
          translatedExample = 'It was by serendipity that he found his calling when getting lost in that museum.';
          break;
        case 'Ineffable':
          translatedExample = 'Facing this magnificent landscape, he felt an ineffable joy.';
          break;
        case 'Acrimonie':
          translatedExample = 'He responded with acrimony to the criticisms made against his project.';
          break;
        case 'Quintessence':
          translatedExample = 'This dish represents the quintessence of traditional French cuisine.';
          break;
        default:
          translatedExample = example;
      }
    } else {
      translatedExample = example;
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
