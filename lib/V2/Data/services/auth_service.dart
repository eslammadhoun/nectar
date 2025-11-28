import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nectar/V2/Data/services/auth_log_state.dart';

class AuthService {
  String get currentUserId => FirebaseAuth.instance.currentUser!.uid;

  Future<String?> getUserName() async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUserId)
            .get();
    if (userDoc.exists) {
      final Map<String, dynamic> userData = userDoc.data()!;
      return userData['user_name'];
    } else {
      return null;
    }
  }

  Future<String?> getUserEmail() async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUserId)
            .get();
    if (userDoc.exists) {
      final Map<String, dynamic> userData = userDoc.data()!;
      return userData['user_email'];
    } else {
      return null;
    }
  }

  Future<void> changeUserName(String newUserName) async {
    try {
      final DocumentReference<Map<String, dynamic>> userDoc =
      await FirebaseFirestore.instance.collection('Users').doc(currentUserId);
      await userDoc.update({'user_name': newUserName});
    } catch (e) {
      throw Exception('Failed to update user name: $e');
    }
  }

  static Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await AuthLogState.saveLoginStatus(true);
      return 'Login Succs';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'password incorrect';
      } else if (e.code == 'user-not-found') {
        return 'This email does not exist.';
      } else if (e.code == 'invalid-email') {
        return 'The email format is invalid.';
      } else {
        return 'Something went wrong. Please try again.';
      }
    }
  }

  static Future<String?> signUp(
    String userName,
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await AuthLogState.saveLoginStatus(true);
      final newUserId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('Users').doc(newUserId).set({
        'user_id': newUserId,
        'user_name': userName,
        'user_email': email,
        'user_Location': '',
      });
      return 'New Account Created';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The email address is already in use by another account';
      } else if (e.code == 'weak-password') {
        return 'Password should be at least 6 characters';
      } else {
        return 'Something Went try again later';
      }
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await AuthLogState.saveLoginStatus(false);
  }
}
