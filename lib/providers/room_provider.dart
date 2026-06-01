import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';

class RoomProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<RoomModel> _activeRooms = [];
  RoomModel? _currentRoom;
  bool _isLoading = false;

  List<RoomModel> get activeRooms => _activeRooms;
  RoomModel? get currentRoom => _currentRoom;
  bool get isLoading => _isLoading;

  Future<void> getActiveRooms() async {
    try {
      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('rooms')
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      _activeRooms = querySnapshot.docs
          .map((doc) => RoomModel.fromJson(doc.data()))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createRoom({
    required String name,
    required String topic,
    required String hostId,
    required String roomImage,
    required String roomType,
  }) async {
    try {
      final roomRef = _firestore.collection('rooms').doc();
      final room = RoomModel(
        id: roomRef.id,
        name: name,
        topic: topic,
        hostId: hostId,
        roomImage: roomImage,
        memberIds: [hostId],
        maxMembers: 100,
        roomType: roomType,
        totalGifts: 0,
        totalCoinsGenerated: 0,
        createdAt: DateTime.now(),
        startedAt: DateTime.now(),
        isActive: true,
        language: 'en',
      );

      await roomRef.set(room.toJson());
      _currentRoom = room;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> joinRoom(String roomId, String userId) async {
    try {
      await _firestore.collection('rooms').doc(roomId).update({
        'memberIds': FieldValue.arrayUnion([userId]),
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> leaveRoom(String roomId, String userId) async {
    try {
      await _firestore.collection('rooms').doc(roomId).update({
        'memberIds': FieldValue.arrayRemove([userId]),
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> addGiftToRoom(String roomId, int giftCoins) async {
    try {
      await _firestore.collection('rooms').doc(roomId).update({
        'totalGifts': FieldValue.increment(1),
        'totalCoinsGenerated': FieldValue.increment(giftCoins),
      });
      notifyListeners();
    } catch (e) {
      //
    }
  }
}
