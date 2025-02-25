import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';
import '../models/settings_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _firebaseService = FirebaseService();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  Future<void> signIn(String email, String password) async {
    try {
      _setLoading(true);
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _loadUserData(userCredential.user!.uid);
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      _setLoading(true);
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final newUser = UserModel(
          id: userCredential.user!.uid,
          email: email,
          name: name,
          settings: UserSettings(),
          createdAt: DateTime.now(),
        );

        await _firebaseService.createUser(newUser);
        _user = newUser;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> _loadUserData(String userId) async {
    try {
      _user = await _firebaseService.getUser(userId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}
