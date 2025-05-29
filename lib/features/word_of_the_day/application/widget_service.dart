import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../domain/models/word.dart';
import 'package:home_widget/home_widget.dart';

class WidgetService {
  static const String appGroupId = 'group.com.eloquence.app';
  static const String wordOfTheDayKey = 'word_of_the_day';

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
}
