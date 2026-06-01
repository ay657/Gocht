import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String id;
  final String name;
  final String topic;
  final String hostId;
  final String roomImage;
  final List<String> memberIds;
  final int maxMembers;
  final String roomType;
  final int totalGifts;
  final int totalCoinsGenerated;
  final DateTime createdAt;
  final DateTime? startedAt;
  final bool isActive;
  final String language;

  RoomModel({
    required this.id,
    required this.name,
    required this.topic,
    required this.hostId,
    required this.roomImage,
    required this.memberIds,
    required this.maxMembers,
    required this.roomType,
    required this.totalGifts,
    required this.totalCoinsGenerated,
    required this.createdAt,
    this.startedAt,
    required this.isActive,
    required this.language,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] as String,
      name: json['name'] as String,
      topic: json['topic'] as String,
      hostId: json['hostId'] as String,
      roomImage: json['roomImage'] as String? ?? '',
      memberIds: List<String>.from(json['memberIds'] as List? ?? []),
      maxMembers: json['maxMembers'] as int? ?? 100,
      roomType: json['roomType'] as String? ?? 'public',
      totalGifts: json['totalGifts'] as int? ?? 0,
      totalCoinsGenerated: json['totalCoinsGenerated'] as int? ?? 0,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      startedAt: json['startedAt'] != null ? (json['startedAt'] as Timestamp).toDate() : null,
      isActive: json['isActive'] as bool? ?? true,
      language: json['language'] as String? ?? 'en',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'topic': topic,
      'hostId': hostId,
      'roomImage': roomImage,
      'memberIds': memberIds,
      'maxMembers': maxMembers,
      'roomType': roomType,
      'totalGifts': totalGifts,
      'totalCoinsGenerated': totalCoinsGenerated,
      'createdAt': createdAt,
      'startedAt': startedAt,
      'isActive': isActive,
      'language': language,
    };
  }

  bool get isFull => memberIds.length >= maxMembers;
}
