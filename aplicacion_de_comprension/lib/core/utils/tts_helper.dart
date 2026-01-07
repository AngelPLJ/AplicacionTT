// lib/core/utils/tts_helper.dart

import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ttsHelperProvider = Provider<TtsHelper>((ref) {
  final ttsHelper = TtsHelper();
  ttsHelper.init();
  return ttsHelper;
});

class TtsHelper {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await _flutterTts.setLanguage("es-MX");
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.35);

      await _flutterTts.setSharedInstance(true);
      await _flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt
      );

      _isInitialized = true;
    } catch (e) {
    }
  }

  Future<void> reproducirFonema(String fonema) async {
    if(!_isInitialized) {
      await init();
    }

    String textoAProcesar = fonema;

    switch (fonema.toLowerCase()) {
      case 'm': textoAProcesar = "mmmmm"; break;
      case 's': textoAProcesar = "sssss"; break; 
      case 'r': textoAProcesar = "rrr"; break;
      case 'l': textoAProcesar = "lllll"; break;
      case 'f': textoAProcesar = "fffff"; break;
      case 'p': textoAProcesar = "puh"; break; 
      case 't': textoAProcesar = "tuh"; break;
      
      default: textoAProcesar = fonema; 
    }

    await _flutterTts.speak(textoAProcesar);
  }
  
  Future<void> decirPalabra(String palabra) async {
    if(!_isInitialized) await init();
    await _flutterTts.setSpeechRate(0.5); 
    await _flutterTts.speak(palabra);
  }

  Future<void> detener() async {
    await _flutterTts.stop();
  }
}