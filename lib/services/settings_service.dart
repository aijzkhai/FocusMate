// services/settings_service.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/users_settings.dart';

class SettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  final String _settingsKey = 'user_settings';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Load settings from local storage
  Future<UserSettings> loadLocalSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsMap = prefs.getString(_settingsKey);

    if (settingsMap != null) {
      return UserSettings.fromMap(Map<String, dynamic>.from(
        json.decode(settingsMap),
      ));
    }
    return UserSettings(); // Return default settings
  }

  // Save settings to local storage
  Future<void> saveLocalSettings(UserSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, json.encode(settings.toMap()));
  }

  // Load settings from Firebase
  Future<UserSettings> loadFirebaseSettings() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final doc = await _firestore
            .collection('users')
            .doc(userId)
            .collection('settings')
            .doc('user_settings')
            .get();

        if (doc.exists) {
          return UserSettings.fromMap(doc.data()!);
        }
      }
      return UserSettings(); // Return default settings
    } catch (e) {
      print('Error loading Firebase settings: $e');
      return UserSettings();
    }
  }

  // Save settings to Firebase
  Future<void> saveFirebaseSettings(UserSettings settings) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('settings')
            .doc('user_settings')
            .set(settings.toMap());
      }
    } catch (e) {
      print('Error saving Firebase settings: $e');
    }
  }

  // Sync local and Firebase settings
  Future<void> syncSettings() async {
    final firebaseSettings = await loadFirebaseSettings();
    await saveLocalSettings(firebaseSettings);
  }
}
