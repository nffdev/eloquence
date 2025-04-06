import 'package:flutter/material.dart';
import '../../../word_of_the_day/domain/models/word.dart';
import '../../../../core/services/tts_service.dart';

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
                        word.word,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
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
                          word.type,
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
                        tooltip: 'Écouter la prononciation',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.redAccent),
                  onPressed: onRemove,
                  tooltip: 'Retirer des favoris',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              word.definition,
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
                word.example,
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
