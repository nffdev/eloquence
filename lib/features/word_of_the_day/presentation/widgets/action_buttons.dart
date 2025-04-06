import 'package:flutter/material.dart';
import '../../../../core/services/tts_service.dart';

class ActionButtons extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final String wordToSpeak;

  const ActionButtons({
    super.key,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.wordToSpeak,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final ttsService = TTSService();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.volume_up_outlined,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
          onPressed: () {
            ttsService.speak(wordToSpeak);
          },
          tooltip: 'Écouter la prononciation',
        ),
        const SizedBox(width: 30),
        IconButton(
          icon: Icon(
            Icons.share_outlined,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
          onPressed: () {
            // TODO : Share functionality
          },
          tooltip: 'Partager',
        ),
        const SizedBox(width: 30),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: isFavorite ? Colors.redAccent : (isDarkMode ? Colors.white70 : Colors.black54),
          ),
          onPressed: onFavoriteToggle,
          tooltip: isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
        ),
      ],
    );
  }
}
