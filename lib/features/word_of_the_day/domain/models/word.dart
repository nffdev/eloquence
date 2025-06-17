class Word {
  final String word;
  final String type;
  final String definition;
  final String example;
  bool isFavorite;
  final String language;

  Word({
    required this.word,
    required this.type,
    required this.definition,
    required this.example,
    this.isFavorite = false,
    this.language = 'fr',
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'],
      type: json['type'],
      definition: json['definition'],
      example: json['example'],
      isFavorite: json['isFavorite'] ?? false,
      language: json['language'] ?? 'fr',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'type': type,
      'definition': definition,
      'example': example,
      'isFavorite': isFavorite,
      'language': language,
    };
  }
}
