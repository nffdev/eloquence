/**
 * Word model
 * Represents a word with its definition, type, example, date and language
 */
class Word {
  constructor(word, type, definition, example, date, isFavorite = false, language = 'fr') {
    this.word = word;
    this.type = type;
    this.definition = definition;
    this.example = example;
    this.date = date;
    this.isFavorite = isFavorite;
    this.language = language;
  }

  toJSON() {
    return {
      word: this.word,
      type: this.type,
      definition: this.definition,
      example: this.example,
      date: this.date,
      isFavorite: this.isFavorite,
      language: this.language
    };
  }

  static fromJSON(json) {
    return new Word(
      json.word,
      json.type,
      json.definition,
      json.example,
      json.date,
      json.isFavorite || false,
      json.language || 'fr'
    );
  }
}

module.exports = Word;
