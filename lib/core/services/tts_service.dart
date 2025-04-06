import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final TTSService _instance = TTSService._internal();
  FlutterTts? _flutterTts;
  bool _isSpeaking = false;
  bool _isAvailable = false;
  
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
        
        await _flutterTts!.setLanguage('fr-FR');
        await _flutterTts!.setSpeechRate(0.5);
        await _flutterTts!.setVolume(1.0);
        await _flutterTts!.setPitch(1.0);
        
        _isAvailable = true;
        debugPrint('TTS initialized successfully');
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

  Future<void> speak(String text) async {
    try {
      if (!_isAvailable) {
        debugPrint('TTS not available, would speak: "$text"');
        return;
      }
      
      if (_isSpeaking) {
        await stop();
      }
      
      _isSpeaking = true;
      debugPrint('Speaking: "$text"');
      await _flutterTts!.speak(text);
      
      await Future.delayed(const Duration(seconds: 2));
      _isSpeaking = false;
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