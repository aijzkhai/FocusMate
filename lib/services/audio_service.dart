import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();

  Future<void> initialize() async {
    // Initialize audio settings
    await _player.setVolume(1.0);
  }

  Future<void> playSound(String soundPath) async {
    await _player.play(AssetSource(soundPath));
  }
}
