import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/models/word.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/word_utils.dart';

class WordRepository {

  Future<Word> getTodaysWord({String language = 'fr'}) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    try {
      final apiWord = await _fetchWordFromApi(language: language);
      if (apiWord != null) {
        debugPrint('Word of the day retrieved from API: ${apiWord.word} (language: ${apiWord.language})');
        await prefs.setString('word_${today}_$language', json.encode(apiWord.toJson()));
        return apiWord;
      }
    } catch (e) {
      debugPrint('Error retrieving word of the day from API: $e');
    }
    
    final savedWordJson = prefs.getString('word_${today}_$language');
    
    if (savedWordJson != null) {
      final wordData = json.decode(savedWordJson);
      debugPrint('Word of the day retrieved for language $language: ${wordData['word']}');
      return Word.fromJson(wordData);
    }
    
    final legacySavedWordJson = prefs.getString('word_$today');
    if (legacySavedWordJson != null) {
      final wordData = json.decode(legacySavedWordJson);
      debugPrint('Legacy word of the day retrieved: ${wordData['word']}');
      final word = Word.fromJson(wordData);
      await prefs.setString('word_${today}_${word.language}', json.encode(word.toJson()));
      
      if (word.language == language) {
        return word;
      }
    }
    
    final filteredWords = WordUtils.fallbackWords.where((w) => w.language == language).toList();
    
    if (filteredWords.isEmpty && language != 'fr') {
      debugPrint('No fallback words found for language $language, using French instead');
      return getTodaysWord(language: 'fr');
    }
    
    if (filteredWords.isEmpty) {
      final randomWord = WordUtils.fallbackWords.first;
      debugPrint('Using generic fallback word: ${randomWord.word}');
      await prefs.setString('word_${today}_${randomWord.language}', json.encode(randomWord.toJson()));
      return randomWord;
    }
    
    final random = DateTime.now().day % filteredWords.length;
    final todaysWord = filteredWords[random];
    
    debugPrint('Word of the day generated locally for language $language: ${todaysWord.word}');
    await prefs.setString('word_${today}_$language', json.encode(todaysWord.toJson()));
    return todaysWord;
  }
  
  Future<Word?> _fetchWordFromApi({String language = 'fr', String? wordName}) async {
    try {
      final String url;
      
      if (wordName != null) {
        url = ApiConstants.getWordByNameUrl(wordName) + '?lang=$language';
        debugPrint('Fetching specific word from API: $wordName (language: $language)');
      } else {
        url = '${ApiConstants.wordOfTheDayUrl}?lang=$language';
        debugPrint('Fetching word of the day from API (language: $language)');
      }
      
      final response = await http.get(Uri.parse(url))
          .timeout(Duration(seconds: ApiConstants.apiTimeoutSeconds));
      
      if (response.statusCode == 200) {
        try {
          if (response.body.isEmpty) {
            debugPrint('API returned empty response');
            return null;
          }
          
          final jsonResponse = json.decode(response.body);
          debugPrint('API response received');
          
          Map<String, dynamic> wordData;
          if (jsonResponse is Map && jsonResponse.containsKey('data')) {
            wordData = jsonResponse['data'];
          } else {
            wordData = jsonResponse;
          }
          
          if (wordData['word'] == null || 
              wordData['type'] == null || 
              wordData['definition'] == null) {
            debugPrint('API response missing required fields in data structure');
            return null;
          }
          
          debugPrint('Successfully parsed word: ${wordData['word']}');
          return Word.fromJson(wordData);
        } catch (parseError) {
          debugPrint('Error parsing API response: $parseError');
          return null;
        }
      } else {
        debugPrint('API error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Execution failed: $e');
      return null;
    }
  }
  
  Future<Word?> getWordByName(String wordName, {String language = 'fr'}) async {
    try {
      final apiWord = await _fetchWordFromApi(language: language, wordName: wordName);
      if (apiWord != null) {
        debugPrint('Word retrieved from API: ${apiWord.word}');
        return apiWord;
      }
    } catch (e) {
      debugPrint('Error retrieving word from API: $e');
    }
    
    final matchingWords = WordUtils.fallbackWords
        .where((w) => w.word.toLowerCase() == wordName.toLowerCase() && w.language == language)
        .toList();
    
    if (matchingWords.isNotEmpty) {
      debugPrint('Word found in fallback words: ${matchingWords.first.word}');
      return matchingWords.first;
    }
    
    if (language != 'fr') {
      return getWordByName(wordName, language: 'fr');
    }
    
    debugPrint('Word not found: $wordName');
    return null;
  }

  Future<void> saveWordFavoriteStatus(Word word, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    
    word.isFavorite = isFavorite;
    
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setString('word_$today', json.encode(word.toJson()));
    
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    
    String wordId = WordUtils.getWordPairId(word);
    
    if (isFavorite) {
      if (!favorites.contains(wordId)) {
        favorites.add(wordId);
      }
    } else {
      favorites.removeWhere((w) => w == wordId);
    }
    
    await prefs.setStringList('favorites', favorites);
  }

  Future<List<Word>> getFavoriteWords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    
    if (favorites.isEmpty) {
      debugPrint('No favorite words found');
      return [];
    }
    
    Map<String, Word> favoriteWordsMap = {};
    
    prefs.getKeys().forEach((key) {
      if (key.startsWith('word_')) {
        try {
          final wordJson = prefs.getString(key);
          if (wordJson != null) {
            final wordData = json.decode(wordJson);
            final word = Word.fromJson(wordData);
            String wordId = WordUtils.getWordPairId(word);
            if (favorites.contains(wordId)) {
              favoriteWordsMap[wordId] = word;
              debugPrint('Loaded favorite word from cache: ${word.word}');
            }
          }
        } catch (e) {
          debugPrint('Error loading word from cache: $e');
        }
      }
    });
    
    List<String> missingWords = favorites.where((wordId) => !favoriteWordsMap.containsKey(wordId)).toList();
    
    if (missingWords.isNotEmpty) {
      debugPrint('Trying to fetch ${missingWords.length} missing favorite words from API');
      
      try {
        final allWords = await getAllWords();
        
        for (final wordName in missingWords) {
          final matchingApiWords = allWords.where((w) => WordUtils.getWordPairId(w) == wordName).toList();
          
          if (matchingApiWords.isNotEmpty) {
            final word = matchingApiWords.first;
            word.isFavorite = true;
            favoriteWordsMap[wordName] = word;
            debugPrint('Found favorite word from API: ${word.word}');
          }
        }
      } catch (e) {
        debugPrint('Error fetching favorite words from API: $e');
      }
    }
    
    missingWords = favorites.where((wordId) => !favoriteWordsMap.containsKey(wordId)).toList();
    
    if (missingWords.isNotEmpty) {
      debugPrint('Using fallback for ${missingWords.length} remaining favorite words');
      
      for (final wordName in missingWords) {
        final matchingWords = WordUtils.fallbackWords.where((w) => WordUtils.getWordPairId(w) == wordName).toList();
        if (matchingWords.isNotEmpty) {
          final word = matchingWords.first;
          word.isFavorite = true;
          favoriteWordsMap[wordName] = word;
          debugPrint('Using fallback word: ${word.word}');
        }
      }
    }
    
    return favoriteWordsMap.values.toList();
  }
  
  Future<bool> isWordFavorite(String word) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    return favorites.contains(word);
  }

  Future<List<Word>> getAllWords({String language = 'fr'}) async {
    try {
      final url = '${ApiConstants.allWordsUrl}?lang=$language';
      final response = await http.get(Uri.parse(url))
          .timeout(Duration(seconds: ApiConstants.apiTimeoutSeconds));
      
      if (response.statusCode == 200) {
        try {
          if (response.body.isEmpty) {
            debugPrint('API returned empty response for getAllWords');
            return _getFallbackWords(language);
          }
          
          final jsonResponse = json.decode(response.body);
          debugPrint('API response received for getAllWords');
          
          List<dynamic> wordsData;
          if (jsonResponse is Map && jsonResponse.containsKey('data')) {
            wordsData = jsonResponse['data'];
          } else if (jsonResponse is List) {
            wordsData = jsonResponse;
          } else {
            debugPrint('API response has unexpected format');
            return _getFallbackWords(language);
          }
          
          final words = wordsData.map((wordData) => Word.fromJson(wordData)).toList();
          debugPrint('Successfully parsed ${words.length} words from API');
          return words;
        } catch (parseError) {
          debugPrint('Error parsing API response for getAllWords: $parseError');
          return _getFallbackWords(language);
        }
      } else {
        debugPrint('API error for getAllWords: ${response.statusCode}');
        return _getFallbackWords(language);
      }
    } catch (e) {
      debugPrint('Execution failed for getAllWords: $e');
      return _getFallbackWords(language);
    }
  }
  
  List<Word> _getFallbackWords(String language) {
    final filteredWords = WordUtils.fallbackWords.where((w) => w.language == language).toList();
    debugPrint('Using ${filteredWords.length} fallback words for language $language');
    return filteredWords;
  }
  
  Future<Word> getRandomWord({String language = 'fr', int seed = 0}) async {
    try {
      final words = await getAllWords(language: language);
      
      if (words.isEmpty && language != 'fr') {
        debugPrint('No words found for language $language, using French instead');
        return getRandomWord(language: 'fr', seed: seed);
      }
      
      if (words.isEmpty) {
        debugPrint('No words available, using first fallback word');
        return WordUtils.fallbackWords.first;
      }
      
      final randomIndex = (DateTime.now().millisecondsSinceEpoch + seed) % words.length;
      final randomWord = words[randomIndex];
      
      debugPrint('Random word selected for language $language with seed $seed: ${randomWord.word}');
      return randomWord;
    } catch (e) {
      debugPrint('Error getting random word: $e, falling back to local words');
      
      final filteredWords = WordUtils.fallbackWords.where((w) => w.language == language).toList();
      
      if (filteredWords.isEmpty && language != 'fr') {
        return getRandomWord(language: 'fr', seed: seed);
      }
      
      if (filteredWords.isEmpty) {
        return WordUtils.fallbackWords.first;
      }
      
      final randomIndex = (DateTime.now().millisecondsSinceEpoch + seed) % filteredWords.length;
      final randomWord = filteredWords[randomIndex];
      
      debugPrint('Random word generated locally for language $language with seed $seed: ${randomWord.word}');
      return randomWord;
    }
  }
}
