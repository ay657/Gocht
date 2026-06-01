import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserModel> _topUsers = [];
  bool _isLoading = false;

  List<UserModel> get topUsers => _topUsers;
  bool get isLoading => _isLoading;

  Future<void> getTopUsersByRank({int limit = 100}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('users')
          .orderBy('totalPoints', descending: true)
          .limit(limit)
          .get();

      _topUsers = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        return UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      //
    }
    return null;
  }

  Future<void> updateUserCoins(String userId, int coinsToAdd) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'coins': FieldValue.increment(coinsToAdd),
        'lastUpdated': DateTime.now(),
      });
      notifyListeners();
    } catch (e) {
      //
    }
  }

  Future<void> updateUserVIP(String userId, String vipLevel, DateTime expiryDate) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'vipLevel': vipLevel,
        'vipExpiryDate': expiryDate,
        'lastUpdated': DateTime.now(),
      });
      notifyListeners();
    } catch (e) {
      //
    }
  }
}
