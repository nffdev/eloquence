/**
 * Word model
 * Represents a word with its definition, type, example and language
 */
class Word {
  constructor(word, type, definition, example, isFavorite = false, language = 'fr') {
    this.word = word;
    this.type = type;
    this.definition = definition;
    this.example = example;
    this.isFavorite = isFavorite;
    this.language = language;
  }

  toJSON() {
    return {
      word: this.word,
      type: this.type,
      definition: this.definition,
      example: this.example,
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
      json.isFavorite || false,
      json.language || 'fr'
    );
  }
}

module.exports = Word;
