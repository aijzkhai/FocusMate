// pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final settings = settingsProvider.settings;

          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              // Background Image Selection
              ListTile(
                title: Text('Background Image'),
                subtitle: Text(settings.backgroundImage),
                onTap: () => _showBackgroundPicker(context, settingsProvider),
              ),

              // Sound Effect Selection
              ListTile(
                title: Text('Sound Effect'),
                subtitle: Text(settings.soundEffect),
                onTap: () => _showSoundPicker(context, settingsProvider),
              ),

              // Timer Display Toggle
              SwitchListTile(
                title: Text('Analog Mode'),
                value: settings.isAnalogMode,
                onChanged: (value) {
                  settingsProvider.updateSettings(isAnalogMode: value);
                },
              ),

              // Default Duration Slider
              ListTile(
                title: Text('Default Duration (minutes)'),
                subtitle: Slider(
                  value: settings.defaultDuration / 60,
                  min: 1,
                  max: 60,
                  divisions: 59,
                  label: '${settings.defaultDuration ~/ 60} minutes',
                  onChanged: (value) {
                    settingsProvider.updateSettings(
                      defaultDuration: (value * 60).round(),
                    );
                  },
                ),
              ),

              // Volume Control
              ListTile(
                title: Text('Volume'),
                subtitle: Slider(
                  value: settings.volume,
                  onChanged: (value) {
                    settingsProvider.updateSettings(volume: value);
                  },
                ),
              ),

              // Theme Selection
              ListTile(
                title: Text('Theme'),
                subtitle: DropdownButton<String>(
                  value: settings.theme,
                  items: ['light', 'dark'].map((theme) {
                    return DropdownMenuItem(
                      value: theme,
                      child: Text(theme.capitalize()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      settingsProvider.updateSettings(theme: value);
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showBackgroundPicker(BuildContext context, SettingsProvider provider) {
    // Implement background image picker dialog
  }

  void _showSoundPicker(BuildContext context, SettingsProvider provider) {
    // Implement sound picker dialog
  }
}
