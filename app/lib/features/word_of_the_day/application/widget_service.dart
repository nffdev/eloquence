import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../domain/models/word.dart';
import 'package:home_widget/home_widget.dart';
import '../../../core/localization/language_provider.dart';
import '../data/word_repository.dart';
import '../../../core/utils/word_utils.dart';

class WidgetService {
  static const String appGroupId = 'group.com.eloquence.widget';
  static const String wordOfTheDayKey = 'word_of_the_day';
  static const String themeKey = 'theme_preference';
  static const String languageKey = 'language_preference';

  static Future<bool> updateWordOfTheDay(Word word) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      
      final wordJson = jsonEncode(word.toJson());
      await HomeWidget.saveWidgetData<String>(wordOfTheDayKey, wordJson);
      
      await HomeWidget.updateWidget(
        name: 'MyHomeWidget',
        iOSName: 'MyHomeWidget',
      );
      
      debugPrint('Widget word of the day updated successfully');
      return true;
    } catch (e) {
      debugPrint('Error updating widget word of the day: $e');
      return false;
    }
  }
  
  static Future<bool> updateTheme(bool isDarkMode) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      await HomeWidget.saveWidgetData<bool>(themeKey, isDarkMode);
      
      await HomeWidget.updateWidget(
        name: 'MyHomeWidget',
        iOSName: 'MyHomeWidget',
      );
      
      debugPrint('Widget theme updated successfully: isDarkMode=$isDarkMode');
      return true;
    } catch (e) {
      debugPrint('Error updating widget theme: $e');
      return false;
    }
  }
  
  static Future<bool> updateLanguage(AppLanguage language) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      await HomeWidget.saveWidgetData<int>(languageKey, language.index);
      
      await HomeWidget.updateWidget(
        name: 'MyHomeWidget',
        iOSName: 'MyHomeWidget',
      );
      
      debugPrint('Widget language updated successfully: language=${language.name}');
      return true;
    } catch (e) {
      debugPrint('Error updating widget language: $e');
      return false;
    }
  }
  
  static Future<bool> updateWidgetLanguageAndWord(AppLanguage language, {Word? currentWord}) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      
      await HomeWidget.saveWidgetData<int>(languageKey, language.index);
      
      final languageCode = language == AppLanguage.french ? 'fr' : 'en';
      Word word;
      
      if (currentWord != null) {
        if (currentWord.language == languageCode) {
          word = currentWord;
        } else {
          Word? translatedWord = WordUtils.getTranslation(currentWord, languageCode);
          if (translatedWord != null) {
            word = translatedWord;
          } else {
            final repository = WordRepository();
            word = await repository.getTodaysWord(language: languageCode);
          }
        }
      } else {
        final repository = WordRepository();
        word = await repository.getTodaysWord(language: languageCode);
      }
      
      final wordJson = jsonEncode(word.toJson());
      await HomeWidget.saveWidgetData<String>(wordOfTheDayKey, wordJson);
      
      final savedWordJson = await HomeWidget.getWidgetData<String>(wordOfTheDayKey);
      if (savedWordJson == null) {
        debugPrint('Warning: Widget word data was not saved properly');
      }
      
      await HomeWidget.updateWidget(
        name: 'MyHomeWidget',
        iOSName: 'MyHomeWidget',
      );
      
      debugPrint('Widget language and word updated successfully: language=${language.name}, word=${word.word}');
      return true;
    } catch (e) {
      debugPrint('Error updating widget language and word: $e');
      return false;
    }
  }
  
  static Future<bool> updateWidgetWordOnly({Word? wordToUse}) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      
      final currentLanguageIndex = await HomeWidget.getWidgetData<int>(languageKey) ?? 0;
      final widgetLanguage = AppLanguage.values[currentLanguageIndex];
      final languageCode = widgetLanguage == AppLanguage.french ? 'fr' : 'en';
      
      Word word;
      if (wordToUse != null) {
        if (wordToUse.language == languageCode) {
          word = wordToUse;
        } else {
           Word? translatedWord = WordUtils.getTranslation(wordToUse, languageCode);
           if (translatedWord != null) {
             word = translatedWord;
           } else {
             final repository = WordRepository();
             word = await repository.getTodaysWord(language: languageCode);
           }
        }
      } else {
        final repository = WordRepository();
        word = await repository.getTodaysWord(language: languageCode);
      }
      
      final wordJson = jsonEncode(word.toJson());
      await HomeWidget.saveWidgetData<String>(wordOfTheDayKey, wordJson);
      
      final savedWordJson = await HomeWidget.getWidgetData<String>(wordOfTheDayKey);
      if (savedWordJson == null) {
        debugPrint('Warning: Widget word data was not saved properly');
      }
      
      await HomeWidget.updateWidget(
        name: 'MyHomeWidget',
        iOSName: 'MyHomeWidget',
      );
      
      debugPrint('Widget word updated successfully (language preserved): word=${word.word}, language=${widgetLanguage.name}');
      return true;
    } catch (e) {
      debugPrint('Error updating widget word only: $e');
      return false;
    }
  }
}
