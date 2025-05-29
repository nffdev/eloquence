import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/models/word.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/word_constants.dart';

class WordRepository {

  Future<Word> getTodaysWord() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    try {
      final apiWord = await _fetchWordFromApi();
      if (apiWord != null) {
        debugPrint('Word of the day retrieved from API: ${apiWord.word}');
        await prefs.setString('word_$today', json.encode(apiWord.toJson()));
        return apiWord;
      }
    } catch (e) {
      debugPrint('Error retrieving word of the day from API: $e');
    }
    
    final savedWordJson = prefs.getString('word_$today');
    
    if (savedWordJson != null) {
      final wordData = json.decode(savedWordJson);
      debugPrint('Word of the day retrieved: ${wordData['word']}');
      return Word.fromJson(wordData);
    } else {
      final random = DateTime.now().day % WordConstants.fallbackWords.length;
      final todaysWord = WordConstants.fallbackWords[random];
      
      debugPrint('Word of the day generated locally: ${todaysWord.word}');
      await prefs.setString('word_$today', json.encode(todaysWord.toJson()));
      return todaysWord;
    }
  }
  
  Future<Word?> _fetchWordFromApi() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.wordOfTheDayUrl))
          .timeout(Duration(seconds: ApiConstants.apiTimeoutSeconds));
      
      if (response.statusCode == 200) {
        try {
          if (response.body.isEmpty) {
            debugPrint('API returned empty response');
            return null;
          }
          
          final jsonResponse = json.decode(response.body);
          debugPrint('API response received: $jsonResponse');
          
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

  Future<void> saveWordFavoriteStatus(Word word, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    
    word.isFavorite = isFavorite;
    
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setString('word_$today', json.encode(word.toJson()));
    
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    
    if (isFavorite) {
      if (!favorites.contains(word.word)) {
        favorites.add(word.word);
      }
    } else {
      favorites.removeWhere((w) => w == word.word);
    }
    
    await prefs.setStringList('favorites', favorites);
  }

  Future<List<Word>> getFavoriteWords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    
    Map<String, Word> favoriteWordsMap = {};
    
    prefs.getKeys().forEach((key) {
      if (key.startsWith('word_')) {
        try {
          final wordJson = prefs.getString(key);
          if (wordJson != null) {
            final wordData = json.decode(wordJson);
            final word = Word.fromJson(wordData);
            if (favorites.contains(word.word)) {
              favoriteWordsMap[word.word] = word;
            }
          }
        } catch (e) {
          debugPrint('Error loading word: $e');
        }
      }
    });
    
    for (final wordName in favorites) {
      if (!favoriteWordsMap.containsKey(wordName)) {
        final matchingWords = WordConstants.fallbackWords.where((w) => w.word == wordName).toList();
        if (matchingWords.isNotEmpty) {
          final word = matchingWords.first;
          word.isFavorite = true;
          favoriteWordsMap[wordName] = word;
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
}
