import 'package:flutter/material.dart';

class WordExample extends StatelessWidget {
  final String example;

  const WordExample({
    super.key,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Example section title
        Text(
          'Exemple :',
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        // Example sentence
        Text(
          '"$example"',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
