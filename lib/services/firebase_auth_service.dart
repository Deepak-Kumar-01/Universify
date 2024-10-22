//Services contains actual functions

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  // Stream to listen for authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  //Sign in with email and password
  Future<User?>signInWithEmail(String email,String password)async{
    try{
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }catch(e){
      print("Error in signing in: $e");
      return null;
    }
  }
  // Sign up with email and password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }
  //Create new user auth
  Future<void>createNewUser(String email,String password)async{
    try{
      UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("NEW USER: $userCredential");
    }catch(e){
      print("createUserWithEmailAndPassword: Failed");
      return;
    }
  }
  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}