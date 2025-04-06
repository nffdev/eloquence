import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ActionButtons({
    super.key,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.share_outlined,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
          onPressed: () {
            // TODO : Share functionality
          },
        ),
        const SizedBox(width: 40),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: isFavorite ? Colors.redAccent : (isDarkMode ? Colors.white70 : Colors.black54),
          ),
          onPressed: onFavoriteToggle,
        ),
      ],
    );
  }
}
