import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> saveTimerSession(Map<String, dynamic> sessionData) async {
    String userId = _auth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('sessions')
        .add(sessionData);
  }

  Future<void> updateUserSettings(Map<String, dynamic> settings) async {
    String userId = _auth.currentUser!.uid;
    await _firestore.collection('users').doc(userId).set(settings);
  }
}
