import '../../../features/word_of_the_day/domain/models/word.dart';
import '../constants/word_constants.dart';

class WordUtils {
  static List<Word> getWordsByLanguage(String language) {
    return WordConstants.wordTranslations
        .map((translation) => language == 'fr' ? translation.french : translation.english)
        .toList();
  }

  static Word? getTranslation(Word word, String targetLanguage) {
    for (var translation in WordConstants.wordTranslations) {
      if (word.language == 'fr' && translation.french.word == word.word && targetLanguage == 'en') {
        return translation.english;
      } else if (word.language == 'en' && translation.english.word == word.word && targetLanguage == 'fr') {
        return translation.french;
      }
    }
    return null;
  }

  static Word getTodaysWord(String language, int dayIndex) {
    final words = getWordsByLanguage(language);
    if (words.isEmpty) return getWordsByLanguage('fr').first;
    return words[dayIndex % words.length];
  }

  static List<Word> get fallbackWords {
    List<Word> allWords = [];
    for (var translation in WordConstants.wordTranslations) {
      allWords.add(translation.french);
      allWords.add(translation.english);
    }
    return allWords;
  }
  
  static String getWordPairId(Word word) {
    for (var translation in WordConstants.wordTranslations) {
      if (translation.french.word == word.word || translation.english.word == word.word) {
        return translation.french.word; 
      }
    }
    return word.word; 
  }
}