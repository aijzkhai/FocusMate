// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      totalPomodorosCompleted:
          (json['totalPomodorosCompleted'] as num?)?.toInt() ?? 0,
      totalMinutesFocused: (json['totalMinutesFocused'] as num?)?.toInt() ?? 0,
      dailyPomodoroCount:
          (json['dailyPomodoroCount'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      averageDailyPomodoros:
          (json['averageDailyPomodoros'] as num?)?.toDouble() ?? 0.0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      focusDistribution:
          (json['focusDistribution'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'totalPomodorosCompleted': instance.totalPomodorosCompleted,
      'totalMinutesFocused': instance.totalMinutesFocused,
      'dailyPomodoroCount': instance.dailyPomodoroCount,
      'averageDailyPomodoros': instance.averageDailyPomodoros,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'focusDistribution': instance.focusDistribution,
    };
