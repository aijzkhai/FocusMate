import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/statistics_provider.dart';
import '../widgets/statistics/stats_card.dart';
import '../widgets/statistics/progress_chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Consumer<StatisticsProvider>(
        builder: (context, stats, child) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              _buildOverviewSection(stats),
              SizedBox(height: 20),
              _buildProgressSection(stats),
              SizedBox(height: 20),
              _buildStreakSection(stats),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOverviewSection(StatisticsProvider stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatsCard(
                title: 'Total Pomodoros',
                value: stats.statistics.totalPomodorosCompleted.toString(),
                icon: Icons.check_circle,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatsCard(
                title: 'Focus Time',
                value: '${stats.statistics.totalMinutesFocused} min',
                icon: Icons.timer,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressSection(StatisticsProvider stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Progress',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          child: ProgressChart(
            data: stats.statistics.dailyPomodoroCount,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakSection(StatisticsProvider stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Streaks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatsCard(
                title: 'Current Streak',
                value: stats.statistics.currentStreak.toString(),
                icon: Icons.local_fire_department,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: StatsCard(
                title: 'Longest Streak',
                value: stats.statistics.longestStreak.toString(),
                icon: Icons.emoji_events,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
