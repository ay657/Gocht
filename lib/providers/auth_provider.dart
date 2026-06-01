import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  UserModel? _userModel;
  bool _isLoading = true;
  String? _errorMessage;

  User? get user => _user;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    _user = _firebaseAuth.currentUser;
    if (_user != null) {
      await _loadUserData();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadUserData() async {
    if (_user == null) return;
    try {
      final docSnapshot = await _firestore.collection('users').doc(_user!.uid).get();
      if (docSnapshot.exists) {
        _userModel = UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<bool> signUp(String email, String password, String username) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;
      await _user?.updateDisplayName(username);

      _userModel = UserModel(
        uid: _user!.uid,
        email: email,
        username: username,
        avatar: '',
        coins: 0,
        gems: 0,
        giftsSent: 0,
        giftsReceived: 0,
        vipLevel: 'none',
        totalPoints: 0,
        rank: 0,
        isOnline: true,
        createdAt: DateTime.now(),
        lastUpdated: DateTime.now(),
      );

      await _firestore.collection('users').doc(_user!.uid).set(_userModel!.toJson());

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;
      await _loadUserData();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _user = null;
      _userModel = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
