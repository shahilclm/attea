import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<void> signUpWithApprovedEmail({
    required String email,required String password,
  })async{

    //check email exist
    final doc=await _firestore.collection('approvedEmails').doc(email).get();

    if(!doc.exists){
      throw Exception('This email is not authorized for signup.');
    }

final userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);

await _firestore.collection('users').doc(userCredential.user!.uid).set({
  'uid':userCredential.user!.uid,
  'email':email,
  'role':'employee',
  'createdAt':FieldValue.serverTimestamp()
});
  }
  Future<UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}