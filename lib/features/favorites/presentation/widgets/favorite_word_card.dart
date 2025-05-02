import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../word_of_the_day/domain/models/word.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';
import '../../../../core/localization/translation_service.dart';

class FavoriteWordCard extends StatelessWidget {
  final Word word;
  final VoidCallback onRemove;

  const FavoriteWordCard({
    super.key,
    required this.word,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final ttsService = TTSService();
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
    String translatedExample;
    
    if (currentLanguage == AppLanguage.english) {
      switch (word.word) {
        case 'Éthéré':
          translatedWord = 'Ethereal';
          translatedDefinition = 'Of unearthly delicacy and lightness, almost celestial';
          translatedExample = 'Her gaze had an ethereal beauty, as if it belonged to a dream.';
          break;
        case 'Sérendipité':
          translatedWord = 'Serendipity';
          translatedDefinition = 'The occurrence of finding valuable things not sought for';
          translatedExample = 'It was by serendipity that he found his calling when getting lost in that museum.';
          break;
        case 'Ineffable':
          translatedWord = 'Ineffable';
          translatedDefinition = 'Too great to be expressed in words';
          translatedExample = 'Facing this magnificent landscape, he felt an ineffable joy.';
          break;
        case 'Acrimonie':
          translatedWord = 'Acrimony';
          translatedDefinition = 'Bitterness or ill feeling that is displayed in speech or behavior';
          translatedExample = 'He responded with acrimony to the criticisms made against his project.';
          break;
        case 'Quintessence':
          translatedWord = 'Quintessence';
          translatedDefinition = 'The most perfect embodiment of something';
          translatedExample = 'This dish represents the quintessence of traditional French cuisine.';
          break;
        default:
          translatedWord = word.word;
          translatedDefinition = word.definition;
          translatedExample = word.example;
      }
    } else {
      translatedWord = word.word;
      translatedDefinition = word.definition;
      translatedExample = word.example;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        translatedWord,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white24 : Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          translatedWordType,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.volume_up_outlined,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                          size: 20,
                        ),
                        onPressed: () {
                          final languageCode = languageProvider.languageCode;
                          ttsService.speak(translatedWord, languageCode: languageCode);
                        },
                        tooltip: AppTranslations.translate('listen_pronunciation', currentLanguage),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.redAccent),
                  onPressed: onRemove,
                  tooltip: AppTranslations.translate('remove_from_favorites', currentLanguage),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              translatedDefinition,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white10 : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode ? Colors.white24 : Colors.black12,
                  width: 1,
                ),
              ),
              child: Text(
                translatedExample,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
