import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';

class ActionButtons extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final String wordToSpeak;
  final String definition;
  final String example;
  final String wordType;

  const ActionButtons({
    super.key,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.wordToSpeak,
    required this.definition,
    required this.example,
    required this.wordType,
  });

  void _shareWord(BuildContext context, AppLanguage language) {
    final isEnglish = language == AppLanguage.english;
    final title = isEnglish ? 'Word of the Day' : 'Mot du Jour';
    final typeLabel = isEnglish ? 'Type' : 'Type';
    final definitionLabel = isEnglish ? 'Definition' : 'Définition';
    final exampleLabel = isEnglish ? 'Example' : 'Exemple';
    final appName = isEnglish ? 'Eloquence App' : 'Application Eloquence';
    
    final shareText = '''
$title: $wordToSpeak
$typeLabel: $wordType
$definitionLabel: $definition
$exampleLabel: "$example"

$appName
''';
    
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final ttsService = TTSService();
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.volume_up_outlined,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
          onPressed: () {
            final languageCode = languageProvider.languageCode;
            ttsService.speak(wordToSpeak, languageCode: languageCode);
          },
          tooltip: AppTranslations.translate('listen_pronunciation', currentLanguage),
        ),
        const SizedBox(width: 30),
        IconButton(
          icon: Icon(
            Icons.share_outlined,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
          onPressed: () {
            _shareWord(context, currentLanguage);
          },
          tooltip: currentLanguage == AppLanguage.french ? 'Partager' : 'Share',
        ),
        const SizedBox(width: 30),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: isFavorite ? Colors.redAccent : (isDarkMode ? Colors.white70 : Colors.black54),
          ),
          onPressed: onFavoriteToggle,
          tooltip: isFavorite 
              ? AppTranslations.translate('remove_from_favorites', currentLanguage) 
              : (currentLanguage == AppLanguage.french ? 'Ajouter aux favoris' : 'Add to favorites'),
        ),
      ],
    );
  }
}
