import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppIconService {
  static const String _iconPreferenceKey = 'app_icon_preference';
  
  static const String defaultIcon = 'AppIcon-Dark';
  static const String lightIcon = 'AppIcon-Light';
  
  static Future<String> getCurrentIcon() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_iconPreferenceKey) ?? defaultIcon;
  }
  
  static Future<bool> setAppIcon(String iconName) async {
    try {
      bool isSupported = await FlutterDynamicIcon.supportsAlternateIcons;
      if (!isSupported) {
        return false;
      }
      
      if (iconName == defaultIcon) {
        await FlutterDynamicIcon.setApplicationIconBadgeNumber(0);
        await FlutterDynamicIcon.setAlternateIconName(null);
      } else {
        await FlutterDynamicIcon.setAlternateIconName(iconName);
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_iconPreferenceKey, iconName);
      
      return true;
    } catch (e) {
      print('Error setting app icon: $e');
      return false;
    }
  }
  
  static Future<bool> isSupported() async {
    try {
      return await FlutterDynamicIcon.supportsAlternateIcons;
    } catch (e) {
      return false;
    }
  }
  
  static List<AppIconOption> getAvailableIcons() {
    return [
      AppIconOption(
        name: defaultIcon,
        displayName: 'Dark Icon',
        description: 'Default dark theme icon',
      ),
      AppIconOption(
        name: lightIcon,
        displayName: 'Light Icon',
        description: 'Light theme icon',
      ),
    ];
  }
}

class AppIconOption {
  final String name;
  final String displayName;
  final String description;
  
  AppIconOption({
    required this.name,
    required this.displayName,
    required this.description,
  });
}