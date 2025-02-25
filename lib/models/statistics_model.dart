import 'package:json_annotation/json_annotation.dart';

part 'statistics_model.g.dart';

@JsonSerializable()
class Statistics {
  final int totalPomodorosCompleted;
  final int totalMinutesFocused;
  final int currentStreak;
  final int longestStreak;
  final Map<String, int> dailyPomodoroCount;
  final double averageDailyPomodoros;
  final Map<String, int> focusDistribution;

  Statistics({
    this.totalPomodorosCompleted = 0,
    this.totalMinutesFocused = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    Map<String, int>? dailyPomodoroCount,
    this.averageDailyPomodoros = 0.0,
    Map<String, int>? focusDistribution,
  })  : this.dailyPomodoroCount = dailyPomodoroCount ?? {},
        this.focusDistribution = focusDistribution ?? {};

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$StatisticsToJson(this);
}
