import 'package:flutter/material.dart';
import '../../domain/models/word.dart';

class WordDisplay extends StatelessWidget {
  final Word word;

  const WordDisplay({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Word type indicator
        Text(
          '(${word.type})',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        // Word of the day
        Text(
          '${word.word} :',
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        // Definition
        Text(
          word.definition,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
