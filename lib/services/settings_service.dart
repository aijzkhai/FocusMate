import '../models/settings_model.dart';

class SettingsService {
  Future<void> initializeFirebase() async {}
  Future<UserSettings> loadLocalSettings() async {
    return const UserSettings(); // Returns default settings
  }

  Future<void> saveLocalSettings(UserSettings settings) async {}
  Future<void> saveFirebaseSettings(UserSettings settings) async {}
}
