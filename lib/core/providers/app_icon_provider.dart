import 'package:flutter/material.dart';
import '../services/app_icon_service.dart';

class AppIconProvider extends ChangeNotifier {
  String _currentIcon = AppIconService.defaultIcon;
  bool _isSupported = false;
  
  String get currentIcon => _currentIcon;
  bool get isSupported => _isSupported;
  
  AppIconProvider() {
    _initializeIcon();
  }
  
  Future<void> _initializeIcon() async {
    _isSupported = await AppIconService.isSupported();
    _currentIcon = await AppIconService.getCurrentIcon();
    notifyListeners();
  }
  
  Future<bool> setIcon(String iconName) async {
    bool success = await AppIconService.setAppIcon(iconName);
    if (success) {
      _currentIcon = iconName;
      notifyListeners();
    }
    return success;
  }
  
  bool isIconSelected(String iconName) {
    return _currentIcon == iconName;
  }
}