import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../data/word_repository.dart';
import '../domain/models/word.dart';
import 'widget_service.dart';
import '../../../core/utils/word_utils.dart';
import '../../../core/constants/word_constants.dart';

class WordProvider extends ChangeNotifier {
  final WordRepository _repository = WordRepository();
  
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  
  late Word _currentWord;
  Word get currentWord => _currentWord;
  
  int _streak = 1;
  int get streak => _streak;
  
  String _currentLanguage = 'fr';
  String get currentLanguage => _currentLanguage;
  
  WordProvider() {
    _currentWord = Word(
      word: 'Chargement...',
      type: '',
      definition: 'Chargement en cours...',
      example: '',
      language: 'fr',
    );
    loadTodaysWord();
  }
  
  void setLanguage(String languageCode) {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      loadTodaysWord();
    }
  }
  
  Future<void> loadTodaysWord() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      
      final rerolledWordPairId = prefs.getString('rerolled_word_pair_$today');
      
      if (rerolledWordPairId != null) {
        _currentWord = await _getWordFromPairId(rerolledWordPairId, _currentLanguage);
        debugPrint('Loaded rerolled word from pair ID: ${_currentWord.word}');
      } else {
        _currentWord = await _repository.getTodaysWord(language: _currentLanguage);
      }
      
      List<String> favorites = prefs.getStringList('favorites') ?? [];
      String wordId = WordUtils.getWordPairId(_currentWord);
      _isFavorite = favorites.contains(wordId);
      _currentWord.isFavorite = _isFavorite;
      await _updateStreak();
      
      await WidgetService.updateWordOfTheDay(_currentWord);
    } catch (e) {
      debugPrint('Error loading today\'s word: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final lastVisit = prefs.getString('last_visit_date');
    
    if (lastVisit == null) {
      _streak = 1;
    } else {
      final lastVisitDate = DateTime.parse(lastVisit);
      final currentDate = DateTime.parse(today);
      
      final difference = currentDate.difference(lastVisitDate).inDays;
      
      if (difference == 1) {
        _streak = (prefs.getInt('streak_count') ?? 1) + 1;
      } else if (difference > 1) {
        _streak = 1;
      } else {
        _streak = prefs.getInt('streak_count') ?? 1;
      }
    }
    
    await prefs.setString('last_visit_date', today);
    await prefs.setInt('streak_count', _streak);
  }
  
  Future<void> toggleFavorite({Word? word}) async {
    if (word != null) {
      final newStatus = !word.isFavorite;
      try {
        await _repository.saveWordFavoriteStatus(word, newStatus);
        
        String currentWordId = WordUtils.getWordPairId(_currentWord);
        String toggledWordId = WordUtils.getWordPairId(word);
        if (currentWordId == toggledWordId) {
          _isFavorite = newStatus;
          _currentWord.isFavorite = newStatus;
        }
        
        notifyListeners();
      } catch (e) {
        debugPrint('Error toggling favorite for ${word.word}: $e');
      }
    } else {
      _isFavorite = !_isFavorite;
      _currentWord.isFavorite = _isFavorite;
      notifyListeners();
      
      try {
        await _repository.saveWordFavoriteStatus(_currentWord, _isFavorite);
      } catch (e) {
        debugPrint('Error toggling favorite: $e');
        _isFavorite = !_isFavorite;
        _currentWord.isFavorite = _isFavorite;
        notifyListeners();
      }
    }
  }
  
  Future<List<Word>> loadFavoriteWords() async {
    try {
      return await _repository.getFavoriteWords();
    } catch (e) {
      debugPrint('Error loading favorite words: $e');
      return [];
    }
  }

  Future<void> rerollWord() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      
      int rerollCount = prefs.getInt('reroll_count_$today') ?? 0;
      rerollCount++;
      
      await prefs.setInt('reroll_count_$today', rerollCount);
      
      final randomWord = await _repository.getRandomWord(
        language: 'fr', 
        seed: rerollCount
      );
      
      String wordPairId = WordUtils.getWordPairId(randomWord);
      await prefs.setString('rerolled_word_pair_$today', wordPairId);
      
      _currentWord = await _getWordFromPairId(wordPairId, _currentLanguage);
      
      final favorites = prefs.getStringList('favorites') ?? [];
      _isFavorite = favorites.contains(wordPairId);
      _currentWord.isFavorite = _isFavorite;
      
      await WidgetService.updateWordOfTheDay(_currentWord);
    } catch (e) {
      debugPrint('Error rerolling word: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<Word> _getWordFromPairId(String pairId, String language) async {
    for (var translation in WordConstants.wordTranslations) {
      if (translation.french.word.toLowerCase() == pairId.toLowerCase()) {
        return language == 'fr' ? translation.french : translation.english;
      }
    }
    
    final fallbackWords = WordUtils.fallbackWords.where((w) => 
      WordUtils.getWordPairId(w).toLowerCase() == pairId.toLowerCase() && 
      w.language == language
    ).toList();
    
    if (fallbackWords.isNotEmpty) {
      return fallbackWords.first;
    }
    
    return await _repository.getTodaysWord(language: language);
  }
}
