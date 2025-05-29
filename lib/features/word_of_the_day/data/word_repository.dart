import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../domain/models/word.dart';
import '../../../core/constants/api_constants.dart';

class WordRepository {
  final List<Word> _words = [
    Word(
      word: 'Éthéré',
      type: 'Adj',
      definition: 'D\'une beauté irréelle, presque céleste',
      example: 'Son regard était d\'une beauté éthérée, comme s\'il appartenait à un rêve.',
      date: '2023-04-06',
    ),
    Word(
      word: 'Sérendipité',
      type: 'Nom',
      definition: 'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
      example: 'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
      date: '2023-04-07',
    ),
    Word(
      word: 'Ineffable',
      type: 'Adj',
      definition: 'Qui ne peut être exprimé par des paroles tant c\'est intense',
      example: 'Face à ce paysage grandiose, il ressentit une joie ineffable.',
      date: '2023-04-08',
    ),
    Word(
      word: 'Acrimonie',
      type: 'Nom',
      definition: 'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
      example: 'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
      date: '2023-04-09',
    ),
    Word(
      word: 'Quintessence',
      type: 'Nom',
      definition: 'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
      example: 'Ce plat représente la quintessence de la cuisine française traditionnelle.',
      date: '2023-04-10',
    ),
  ];

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
      final random = DateTime.now().day % _words.length;
      final todaysWord = _words[random];
      
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
        final matchingWords = _words.where((w) => w.word == wordName).toList();
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
