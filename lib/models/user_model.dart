import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String username;
  final String avatar;
  final int coins;
  final int gems;
  final int giftsSent;
  final int giftsReceived;
  final String vipLevel;
  DateTime? vipExpiryDate;
  final int totalPoints;
  final int rank;
  final bool isOnline;
  final DateTime createdAt;
  final DateTime lastUpdated;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.avatar,
    required this.coins,
    required this.gems,
    required this.giftsSent,
    required this.giftsReceived,
    required this.vipLevel,
    this.vipExpiryDate,
    required this.totalPoints,
    required this.rank,
    required this.isOnline,
    required this.createdAt,
    required this.lastUpdated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] as String? ?? '',
      coins: json['coins'] as int? ?? 0,
      gems: json['gems'] as int? ?? 0,
      giftsSent: json['giftsSent'] as int? ?? 0,
      giftsReceived: json['giftsReceived'] as int? ?? 0,
      vipLevel: json['vipLevel'] as String? ?? 'none',
      vipExpiryDate: json['vipExpiryDate'] != null
          ? (json['vipExpiryDate'] as Timestamp).toDate()
          : null,
      totalPoints: json['totalPoints'] as int? ?? 0,
      rank: json['rank'] as int? ?? 0,
      isOnline: json['isOnline'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      lastUpdated: (json['lastUpdated'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'avatar': avatar,
      'coins': coins,
      'gems': gems,
      'giftsSent': giftsSent,
      'giftsReceived': giftsReceived,
      'vipLevel': vipLevel,
      'vipExpiryDate': vipExpiryDate,
      'totalPoints': totalPoints,
      'rank': rank,
      'isOnline': isOnline,
      'createdAt': createdAt,
      'lastUpdated': lastUpdated,
    };
  }

  bool get isVip => vipLevel != 'none' && (vipExpiryDate?.isAfter(DateTime.now()) ?? false);
}
