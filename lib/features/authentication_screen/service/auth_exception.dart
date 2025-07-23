import 'package:firebase_auth/firebase_auth.dart';

class AuthException {
  static String getFriendlyError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'This email is already registered.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password.';
        default:
          return 'Authentication error: ${error.message}';
      }
    } else if (error is FirebaseException) {
      return 'Firebase error: ${error.message}';
    } else if (error.toString().contains('not authorized')) {
      return 'This email is not authorized to sign up.';
    } else {
      return 'Something went wrong. Please try again.';
    }
  }
  String getFriendlyLoginError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email format.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      default:
        return e.message ?? 'Login failed.';
    }
  }


}