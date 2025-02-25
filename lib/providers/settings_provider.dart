// providers/settings_provider.dart
import 'package:flutter/foundation.dart';
import '../models/settings_model.dart';
import '../services/settings_service.dart';
import 'package:logging/logging.dart';

/// A ChangeNotifier that manages user settings state and persistence
class SettingsProvider with ChangeNotifier {
  // Internal state
  UserSettings _settings = const UserSettings();
  final SettingsService _settingsService = SettingsService();
  bool _isLoading = false;
  String? _error;

  // Getters for accessing state
  UserSettings get settings => _settings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Constructor that initializes by loading settings
  SettingsProvider() {
    _loadSettings();
  }

  /// Loads settings from local storage and Firebase
  /// Sets loading state and handles errors
  Future<void> _loadSettings() async {
    if (_isLoading) return; // Prevent multiple simultaneous loads

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _settingsService.initializeFirebase();
      final localSettings = await _settingsService.loadLocalSettings();
      _settings = localSettings;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      print('Error loading settings: $e');
      // Load defaults if there's an error
      _settings = const UserSettings();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Updates multiple settings at once with error handling
  Future<void> updateSettings({
    String? backgroundImage,
    String? soundEffect,
    bool? isAnalogMode,
    int? defaultDuration,
    double? volume,
    String? theme,
  }) async {
    try {
      // Validate inputs
      if (defaultDuration != null && defaultDuration < 1) {
        throw ArgumentError('Duration must be positive');
      }
      if (volume != null && (volume < 0 || volume > 1)) {
        throw ArgumentError('Volume must be between 0 and 1');
      }

      final newSettings = UserSettings(
        backgroundImage: backgroundImage ?? _settings.backgroundImage,
        soundEffect: soundEffect ?? _settings.soundEffect,
        isAnalogMode: isAnalogMode ?? _settings.isAnalogMode,
        defaultDuration: defaultDuration ?? _settings.defaultDuration,
        volume: volume ?? _settings.volume,
        theme: theme ?? _settings.theme,
        timerDurations: _settings.timerDurations,
        notifications: _settings.notifications,
        vibration: _settings.vibration,
        autoStartBreaks: _settings.autoStartBreaks,
        autoStartPomodoros: _settings.autoStartPomodoros,
      );

      // Save locally first
      await _settingsService.saveLocalSettings(newSettings);

      // Then try Firebase, but don't block on failure
      try {
        await _settingsService.saveFirebaseSettings(newSettings);
      } catch (e) {
        Logger.root.warning('Firebase sync failed: $e');
        // Continue anyway as we saved locally
      }

      _settings = newSettings;
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  /// Updates the duration for a specific timer type
  /// @param type The timer type (e.g., 'pomodoro', 'shortBreak')
  /// @param duration The new duration in minutes
  Future<void> updateTimerDuration(String type, int duration) async {
    final Map<String, int> newDurations = Map.from(_settings.timerDurations);
    newDurations[type] = duration;

    _settings = UserSettings(
      timerDurations: newDurations,
      backgroundImage: _settings.backgroundImage,
      soundEffect: _settings.soundEffect,
      isAnalogMode: _settings.isAnalogMode,
      defaultDuration: _settings.defaultDuration,
      volume: _settings.volume,
      theme: _settings.theme,
    );

    await _settingsService.saveLocalSettings(_settings);
    await _settingsService.saveFirebaseSettings(_settings);
    notifyListeners();
  }

  /// Updates the theme setting
  /// @param theme The new theme name
  Future<void> updateTheme(String theme) async {
    _settings = UserSettings(
      timerDurations: _settings.timerDurations,
      backgroundImage: _settings.backgroundImage,
      soundEffect: _settings.soundEffect,
      isAnalogMode: _settings.isAnalogMode,
      defaultDuration: _settings.defaultDuration,
      volume: _settings.volume,
      theme: theme,
    );

    await _settingsService.saveLocalSettings(_settings);
    await _settingsService.saveFirebaseSettings(_settings);
    notifyListeners();
  }

  /// Toggles between analog and digital display mode
  /// @param value True for analog, false for digital
  Future<void> toggleAnalogMode(bool value) async {
    _settings = UserSettings(
      timerDurations: _settings.timerDurations,
      backgroundImage: _settings.backgroundImage,
      soundEffect: _settings.soundEffect,
      isAnalogMode: value,
      defaultDuration: _settings.defaultDuration,
      volume: _settings.volume,
      theme: _settings.theme,
    );

    await _settingsService.saveLocalSettings(_settings);
    await _settingsService.saveFirebaseSettings(_settings);
    notifyListeners();
  }

  /// Helper method to reduce code duplication in toggle methods
  Future<void> _updateSettingsWithToggle({
    required String fieldName,
    required bool value,
  }) async {
    try {
      final newSettings = UserSettings(
        timerDurations: _settings.timerDurations,
        backgroundImage: _settings.backgroundImage,
        soundEffect: _settings.soundEffect,
        isAnalogMode: _settings.isAnalogMode,
        defaultDuration: _settings.defaultDuration,
        volume: _settings.volume,
        theme: _settings.theme,
        notifications:
            fieldName == 'notifications' ? value : _settings.notifications,
        vibration: fieldName == 'vibration' ? value : _settings.vibration,
        autoStartBreaks:
            fieldName == 'autoStartBreaks' ? value : _settings.autoStartBreaks,
        autoStartPomodoros: fieldName == 'autoStartPomodoros'
            ? value
            : _settings.autoStartPomodoros,
      );

      await _settingsService.saveLocalSettings(newSettings);

      try {
        await _settingsService.saveFirebaseSettings(newSettings);
      } catch (e) {
        Logger.root.warning('Firebase sync failed: $e');
      }

      _settings = newSettings;
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  /// Toggles notification settings
  /// @param value True to enable notifications, false to disable
  Future<void> toggleNotifications(bool value) async {
    await _updateSettingsWithToggle(fieldName: 'notifications', value: value);
  }

  /// Toggles vibration feedback
  /// @param value True to enable vibration, false to disable
  Future<void> toggleVibration(bool value) async {
    await _updateSettingsWithToggle(fieldName: 'vibration', value: value);
  }

  /// Toggles automatic start of break periods
  /// @param value True to auto-start breaks, false for manual start
  Future<void> toggleAutoStartBreaks(bool value) async {
    await _updateSettingsWithToggle(fieldName: 'autoStartBreaks', value: value);
  }

  /// Toggles automatic start of pomodoro periods
  /// @param value True to auto-start pomodoros, false for manual start
  Future<void> toggleAutoStartPomodoros(bool value) async {
    await _updateSettingsWithToggle(
        fieldName: 'autoStartPomodoros', value: value);
  }

  /// Updates the volume level for sound effects
  /// @param value Volume level between 0.0 and 1.0
  Future<void> updateVolume(double value) async {
    _settings = UserSettings(
      timerDurations: _settings.timerDurations,
      backgroundImage: _settings.backgroundImage,
      soundEffect: _settings.soundEffect,
      isAnalogMode: _settings.isAnalogMode,
      defaultDuration: _settings.defaultDuration,
      volume: value,
      theme: _settings.theme,
      notifications: _settings.notifications,
      vibration: _settings.vibration,
    );

    await _settingsService.saveLocalSettings(_settings);
    await _settingsService.saveFirebaseSettings(_settings);
    notifyListeners();
  }
}
