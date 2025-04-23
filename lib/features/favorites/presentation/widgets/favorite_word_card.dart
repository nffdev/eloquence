import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../word_of_the_day/domain/models/word.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';

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
    
    String translatedExample = word.example;
    final exampleKey = 'example_${word.word.toLowerCase()}';
    final translatedExampleValue = AppTranslations.translate(exampleKey, currentLanguage);
    if (translatedExampleValue != exampleKey) {
      translatedExample = translatedExampleValue;
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
                          ttsService.speak(word.word);
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
