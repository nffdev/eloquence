import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../domain/models/word.dart';
import 'package:home_widget/home_widget.dart';

class WidgetService {
  static const String appGroupId = 'group.com.eloquence.widget';
  static const String wordOfTheDayKey = 'word_of_the_day';
  static const String themeKey = 'theme_preference';

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
}
