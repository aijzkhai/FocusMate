// models/user_settings.dart
class UserSettings {
  String backgroundImage;
  String soundEffect;
  bool isAnalogMode;
  int defaultDuration;
  double volume;
  String theme;

  UserSettings({
    this.backgroundImage = 'default.jpg',
    this.soundEffect = 'bell.mp3',
    this.isAnalogMode = false,
    this.defaultDuration = 1500, // 25 minutes in seconds
    this.volume = 1.0,
    this.theme = 'light',
  });

  // Convert settings to a Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'backgroundImage': backgroundImage,
      'soundEffect': soundEffect,
      'isAnalogMode': isAnalogMode,
      'defaultDuration': defaultDuration,
      'volume': volume,
      'theme': theme,
    };
  }

  // Create settings from a Map (for Firebase retrieval)
  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      backgroundImage: map['backgroundImage'] ?? 'default.jpg',
      soundEffect: map['soundEffect'] ?? 'bell.mp3',
      isAnalogMode: map['isAnalogMode'] ?? false,
      defaultDuration: map['defaultDuration'] ?? 1500,
      volume: map['volume']?.toDouble() ?? 1.0,
      theme: map['theme'] ?? 'light',
    );
  }
}
