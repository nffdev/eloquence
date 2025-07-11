import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../domain/models/word.dart';
import 'package:home_widget/home_widget.dart';
import '../../../core/localization/language_provider.dart';
import '../data/word_repository.dart';

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
  
  static Future<bool> updateWidgetLanguageAndWord(AppLanguage language) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      
      await HomeWidget.saveWidgetData<int>(languageKey, language.index);
      
      final repository = WordRepository();
      final languageCode = language == AppLanguage.french ? 'fr' : 'en';
      final word = await repository.getTodaysWord(language: languageCode);
      
      final wordJson = jsonEncode(word.toJson());
      await HomeWidget.saveWidgetData<String>(wordOfTheDayKey, wordJson);
      
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
  
  static Future<bool> updateWidgetWordOnly() async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      
      final currentLanguageIndex = await HomeWidget.getWidgetData<int>(languageKey) ?? 0;
      final widgetLanguage = AppLanguage.values[currentLanguageIndex];
      
      final repository = WordRepository();
      final languageCode = widgetLanguage == AppLanguage.french ? 'fr' : 'en';
      final word = await repository.getTodaysWord(language: languageCode);
      
      final wordJson = jsonEncode(word.toJson());
      await HomeWidget.saveWidgetData<String>(wordOfTheDayKey, wordJson);
      
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
