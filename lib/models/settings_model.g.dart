// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) => UserSettings(
      theme: json['theme'] as String? ?? 'system',
      backgroundImage: json['backgroundImage'] as String? ?? 'default.jpg',
      soundEffect: json['soundEffect'] as String? ?? 'bell.mp3',
      isAnalogMode: json['isAnalogMode'] as bool? ?? false,
      timerDurations: (json['timerDurations'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      autoStartBreaks: json['autoStartBreaks'] as bool? ?? false,
      autoStartPomodoros: json['autoStartPomodoros'] as bool? ?? false,
      volume: (json['volume'] as num?)?.toDouble() ?? 1.0,
      vibration: json['vibration'] as bool? ?? true,
      notifications: json['notifications'] as bool? ?? true,
    );

Map<String, dynamic> _$UserSettingsToJson(UserSettings instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'backgroundImage': instance.backgroundImage,
      'soundEffect': instance.soundEffect,
      'isAnalogMode': instance.isAnalogMode,
      'timerDurations': instance.timerDurations,
      'autoStartBreaks': instance.autoStartBreaks,
      'autoStartPomodoros': instance.autoStartPomodoros,
      'volume': instance.volume,
      'vibration': instance.vibration,
      'notifications': instance.notifications,
    };
