import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meow/models/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  getUser(String userId) {}

  createUser(UserModel newUser) {}
}
