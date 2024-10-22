//Controller will ask for functions from Services
//This file will act as the bridge between your UI and the AuthServices, managing the state of authentication.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:universify/services/firebase_auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  User? _user; //FirebaseAuth User
  String? _errorMsg;

  //accessing private variable
  User? get user=>_user;
  String? get errorMsg=>_errorMsg;

  //Monitor auth changes logic written in service class
  AuthController() {
    _authServices.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  //Controllers Sign in method block
  Future<User?> signIn(String email,String password)async{
    _user=await _authServices.signInWithEmail(email, password);
    if(_user==null){
      _errorMsg="Failed to sign in. Please check your credentials";
    }else{
      _errorMsg=null;
    }
    notifyListeners();
    return _user;
  }
  //New Auth
  Future<void>newAuthForUser(String email,String password)async{
    _authServices.createNewUser(email, password);
  }
  // Sign out method
  Future<void> signOut() async {
    await _authServices.signOut();
    _user = null;
    notifyListeners();
  }

  // Check current user
  // void checkCurrentUser() {
  //   _user = _authServices.getCurrentUser();
  //   notifyListeners();
  // }
}
