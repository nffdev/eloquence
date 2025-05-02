class Word {
  final String word;
  final String type;
  final String definition;
  final String example;
  final String date;
  bool isFavorite;

  Word({
    required this.word,
    required this.type,
    required this.definition,
    required this.example,
    required this.date,
    this.isFavorite = false,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'],
      type: json['type'],
      definition: json['definition'],
      example: json['example'],
      date: json['date'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'type': type,
      'definition': definition,
      'example': example,
      'date': date,
      'isFavorite': isFavorite,
    };
  }
}
