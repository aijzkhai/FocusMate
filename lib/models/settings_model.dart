import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class UserSettings {
  final Map<String, int> timerDurations;
  final String theme;
  final String backgroundImage;
  final String soundEffect;
  final bool isAnalogMode;
  final bool autoStartBreaks;
  final bool autoStartPomodoros;
  final double volume;
  final bool vibration;
  final bool notifications;
  final int defaultDuration;

  const UserSettings({
    Map<String, int>? timerDurations,
    this.theme = 'system',
    this.backgroundImage = 'default.jpg',
    this.soundEffect = 'bell.mp3',
    this.isAnalogMode = false,
    this.autoStartBreaks = false,
    this.autoStartPomodoros = false,
    this.volume = 1.0,
    this.vibration = true,
    this.notifications = true,
    this.defaultDuration = 25,
  }) : timerDurations = timerDurations ??
            const {
              'pomodoro': 25,
              'shortBreak': 5,
              'longBreak': 15,
            };

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);
}
