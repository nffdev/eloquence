import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final TTSService _instance = TTSService._internal();
  FlutterTts? _flutterTts;
  bool _isSpeaking = false;
  bool _isAvailable = false;
  String _currentLanguage = 'fr-FR';
  
  factory TTSService() {
    return _instance;
  }

  TTSService._internal() {
    _initTTS();
  }
  
  Future<void> _initTTS() async {
    try {
      if (_isPlatformSupported()) {
        _flutterTts = FlutterTts();
        
        if (Platform.isIOS) {
          await _flutterTts!.setSharedInstance(true);
          await _flutterTts!.setIosAudioCategory(
            IosTextToSpeechAudioCategory.playback,
            [IosTextToSpeechAudioCategoryOptions.allowBluetooth]
          );
        }
        
        final availableLanguages = await _flutterTts!.getLanguages;
        debugPrint('TTS available languages: $availableLanguages');
        
        String languageToUse = _currentLanguage;
        if (Platform.isIOS) {
          const iosFrenchOptions = ['fr-FR', 'fr_FR', 'fra-FRA', 'fr_CA', 'fra']; 
          for (final lang in iosFrenchOptions) {
            if (availableLanguages.contains(lang)) {
              languageToUse = lang;
              break;
            }
          }
        }
        
        await _flutterTts!.setLanguage(languageToUse);
        _currentLanguage = languageToUse;
        
        await _flutterTts!.setSpeechRate(Platform.isIOS ? 0.4 : 0.5);
        await _flutterTts!.setVolume(1.0);
        await _flutterTts!.setPitch(1.0);
        
        _flutterTts!.setStartHandler(() {
          debugPrint('TTS started');
          _isSpeaking = true;
        });
        
        _flutterTts!.setCompletionHandler(() {
          debugPrint('TTS completed');
          _isSpeaking = false;
        });
        
        _flutterTts!.setErrorHandler((error) {
          debugPrint('TTS error: $error');
          _isSpeaking = false;
        });
        
        _isAvailable = true;
        debugPrint('TTS initialized successfully with language: $_currentLanguage');
      } else {
        debugPrint('TTS not available on this platform');
      }
    } catch (e) {
      debugPrint('Error initializing TTS: $e');
      _isAvailable = false;
    }
  }
  
  bool _isPlatformSupported() {
    return !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  }

  Future<void> setLanguage(String languageCode) async {
    if (!_isAvailable) return;
    
    String ttsLanguage;
    if (languageCode == 'en') {
      ttsLanguage = Platform.isIOS ? 'en-US' : 'en-US';
    } else {
      ttsLanguage = Platform.isIOS ? 'fr-FR' : 'fr-FR';
    }
    
    if (_currentLanguage != ttsLanguage) {
      try {
        final availableLanguages = await _flutterTts!.getLanguages;
        
        if (Platform.isIOS && !availableLanguages.contains(ttsLanguage)) {
          final options = languageCode == 'en' 
              ? ['en-US', 'en_US', 'en-GB', 'en_GB', 'eng']
              : ['fr-FR', 'fr_FR', 'fra-FRA', 'fr_CA', 'fra'];
          
          for (final lang in options) {
            if (availableLanguages.contains(lang)) {
              ttsLanguage = lang;
              break;
            }
          }
        }
        
        _currentLanguage = ttsLanguage;
        await _flutterTts!.setLanguage(_currentLanguage);
        debugPrint('TTS language changed to: $_currentLanguage');
      } catch (e) {
        debugPrint('Error setting TTS language: $e');
      }
    }
  }

  Future<void> speak(String text, {String? languageCode}) async {
    try {
      if (!_isAvailable) {
        debugPrint('TTS not available, would speak: "$text"');
        return;
      }
      
      if (languageCode != null) {
        await setLanguage(languageCode);
      }
      
      if (_isSpeaking) {
        await stop();
        await Future.delayed(const Duration(milliseconds: 300));
      }
      
      String textToSpeak = text;
      if (Platform.isIOS) {
        textToSpeak = text
            .replaceAll('"', '')
            .replaceAll('\n', ' ')
            .trim();
      }
      
      debugPrint('Speaking in $_currentLanguage: "$textToSpeak"');
      
      _flutterTts!.setStartHandler(() {
        debugPrint('TTS started');
        _isSpeaking = true;
      });
      
      _flutterTts!.setCompletionHandler(() {
        debugPrint('TTS completed');
        _isSpeaking = false;
      });
      
      _flutterTts!.setErrorHandler((error) {
        debugPrint('TTS error: $error');
        _isSpeaking = false;
      });
      
      _isSpeaking = true;
      await _flutterTts!.speak(textToSpeak);
      
    } catch (e) {
      debugPrint('Error speaking text: $e');
      _isSpeaking = false;
    }
  }

  Future<void> stop() async {
    try {
      if (!_isAvailable) return;
      
      await _flutterTts!.stop();
      _isSpeaking = false;
    } catch (e) {
      debugPrint('Error stopping TTS: $e');
    }
  }

  Future<void> dispose() async {
    try {
      if (!_isAvailable) return;
      
      await _flutterTts!.stop();
      _isSpeaking = false;
    } catch (e) {
      debugPrint('Error disposing TTS: $e');
    }
  }
}