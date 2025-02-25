import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../widgets/common/custom_switch_tile.dart';
import '../../utils/extensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              _buildSection(
                'Timer',
                [
                  _buildDurationSetting(
                    context,
                    'Pomodoro Length',
                    settings.settings.timerDurations['pomodoro'] ?? 25,
                    (value) => settings.updateTimerDuration('pomodoro', value),
                  ),
                  _buildDurationSetting(
                    context,
                    'Short Break Length',
                    settings.settings.timerDurations['shortBreak'] ?? 5,
                    (value) =>
                        settings.updateTimerDuration('shortBreak', value),
                  ),
                  _buildDurationSetting(
                    context,
                    'Long Break Length',
                    settings.settings.timerDurations['longBreak'] ?? 15,
                    (value) => settings.updateTimerDuration('longBreak', value),
                  ),
                ],
              ),
              _buildSection(
                'Appearance',
                [
                  ListTile(
                    title: Text('Theme'),
                    trailing: DropdownButton<String>(
                      value: settings.settings.theme,
                      items: ['system', 'light', 'dark'].map((theme) {
                        return DropdownMenuItem(
                          value: theme,
                          child: Text(theme.capitalize()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          settings.updateTheme(value);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Background'),
                    trailing: IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () => _showBackgroundPicker(context),
                    ),
                  ),
                  CustomSwitchTile(
                    title: 'Analog Timer',
                    value: settings.settings.isAnalogMode,
                    onChanged: settings.toggleAnalogMode,
                  ),
                ],
              ),
              _buildSection(
                'Sound & Notifications',
                [
                  ListTile(
                    title: Text('Timer Sound'),
                    trailing: IconButton(
                      icon: Icon(Icons.music_note),
                      onPressed: () => _showSoundPicker(context),
                    ),
                  ),
                  CustomSwitchTile(
                    title: 'Notifications',
                    value: settings.settings.notifications,
                    onChanged: settings.toggleNotifications,
                  ),
                  CustomSwitchTile(
                    title: 'Vibration',
                    value: settings.settings.vibration,
                    onChanged: settings.toggleVibration,
                  ),
                  ListTile(
                    title: Text('Volume'),
                    subtitle: Slider(
                      value: settings.settings.volume,
                      onChanged: settings.updateVolume,
                    ),
                  ),
                ],
              ),
              _buildSection(
                'Automation',
                [
                  CustomSwitchTile(
                    title: 'Auto-start Breaks',
                    value: settings.settings.autoStartBreaks,
                    onChanged: settings.toggleAutoStartBreaks,
                  ),
                  CustomSwitchTile(
                    title: 'Auto-start Pomodoros',
                    value: settings.settings.autoStartPomodoros,
                    onChanged: settings.toggleAutoStartPomodoros,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        Divider(),
      ],
    );
  }

  Widget _buildDurationSetting(
    BuildContext context,
    String label,
    int duration,
    Function(int) onChanged,
  ) {
    return ListTile(
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () => onChanged(duration - 1),
          ),
          Text('$duration min'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => onChanged(duration + 1),
          ),
        ],
      ),
    );
  }

  void _showBackgroundPicker(BuildContext context) {
    // Implement background picker dialog
  }

  void _showSoundPicker(BuildContext context) {
    // Implement sound picker dialog
  }
}
