//Controller will ask for functions from Services
//This file will act as the bridge between your UI and the AuthServices, managing the state of authentication.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:universify/services/firebase_auth_service.dart';

import '../modals/user_model.dart';

class AuthController with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  User? _user; //FirebaseAuth User
  AppUser? _appUser;
  String? _errorMsg;

  //accessing private variable
  User? get user => _user;
  AppUser? get appUser => _appUser;
  String? get errorMsg => _errorMsg;

  //Monitor auth changes logic written in service class
  AuthController() {
    _authServices.authStateChanges.listen((user) async {
      _user = user;
      _appUser=await fetchUserData();
      notifyListeners();
    });
  }

  //Controllers Sign in method block
  Future<User?> signIn(String email, String password) async {
    _user = await _authServices.signInWithEmail(email, password);
    if (_user == null) {
      _errorMsg = "Failed to sign in. Please check your credentials";
    } else {
      // await _listenToUserData();
      // _appUser=await _fetchUserData();
      print("App User after fetching it :${appUser?.role}");
      _errorMsg = null;
    }
    notifyListeners();
    return _user;
  }

  //New Auth
  Future<String?> newAuthForUser(String email, String password) async {
    String? uid = await _authServices.createNewUser(email, password);
    return uid;
  }

  // Sign out method
  Future<void> signOut() async {
    await _authServices.signOut();
    _user = null;
    notifyListeners();
  }

  Future<AppUser?> fetchUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          // .collection('degrees/mca/first-year/sec-a/users')
          .collection('users')
          .doc(_user!.uid)
          .get();
      return AppUser.fromJson(doc.data() as Map<String, Object?>);
    } catch (e) {
      print("Data Fetching Failed:$e");
    }
    print("Fetched User Data inside MyAuthProvider:${_appUser?.name}");
    notifyListeners();
    return null;
  }

  Future<void> _listenToUserData() async {
    try {
      FirebaseFirestore.instance
          .collection('degrees/MCA/First-Year/Sec-A/users')
          .doc(_user!.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          _appUser = AppUser.fromJson(snapshot.data() as Map<String, Object?>);
          print("App User: ${_appUser}");
          notifyListeners();
        }
      });
    } catch (e) {
      print("$e");
    }
  }
  // Check current user
  // void checkCurrentUser() {
  //   _user = _authServices.getCurrentUser();
  //   notifyListeners();
  // }
}
