// providers/settings_provider.dart
import 'package:flutter/foundation.dart';
import '../models/users_settings.dart';
import '../services/settings_service.dart';

class SettingsProvider with ChangeNotifier {
  UserSettings _settings = UserSettings();
  final SettingsService _settingsService = SettingsService();
  bool _isLoading = false;

  UserSettings get settings => _settings;
  bool get isLoading => _isLoading;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _isLoading = true;
    notifyListeners();

    // Load local settings first for quick access
    _settings = await _settingsService.loadLocalSettings();
    notifyListeners();

    // Then sync with Firebase settings
    await _settingsService.syncSettings();
    _settings = await _settingsService.loadLocalSettings();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateSettings({
    String? backgroundImage,
    String? soundEffect,
    bool? isAnalogMode,
    int? defaultDuration,
    double? volume,
    String? theme,
  }) async {
    if (backgroundImage != null) _settings.backgroundImage = backgroundImage;
    if (soundEffect != null) _settings.soundEffect = soundEffect;
    if (isAnalogMode != null) _settings.isAnalogMode = isAnalogMode;
    if (defaultDuration != null) _settings.defaultDuration = defaultDuration;
    if (volume != null) _settings.volume = volume;
    if (theme != null) _settings.theme = theme;

    // Save to both local and Firebase
    await _settingsService.saveLocalSettings(_settings);
    await _settingsService.saveFirebaseSettings(_settings);

    notifyListeners();
  }

  String? _error;

  String? get error => _error;

  Future<void> _loadSettings() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _settingsService.initializeFirebase();
      _settings = await _settingsService.loadLocalSettings();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      print('Error loading settings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
