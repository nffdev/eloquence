import 'package:flutter/foundation.dart';
import '../data/word_repository.dart';
import '../domain/models/word.dart';

class WordProvider extends ChangeNotifier {
  final WordRepository _repository = WordRepository();
  
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  
  late Word _currentWord;
  Word get currentWord => _currentWord;
  
  Future<void> loadTodaysWord() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _currentWord = await _repository.getTodaysWord();
      _isFavorite = _currentWord.isFavorite;
    } catch (e) {
      debugPrint('Error loading today\'s word: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void toggleFavorite() async {
    _isFavorite = !_isFavorite;
    notifyListeners();
    
    try {
      await _repository.saveWordFavoriteStatus(_currentWord, _isFavorite);
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      _isFavorite = !_isFavorite;
      notifyListeners();
    }
  }
}
