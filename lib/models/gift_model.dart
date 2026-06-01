class GiftModel {
  final String id;
  final String name;
  final String icon;
  final int coinsPrice;
  final int gemsPrice;
  final String animation;
  final String category;
  final bool isPopular;
  final int sendCount;

  GiftModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.coinsPrice,
    required this.gemsPrice,
    required this.animation,
    required this.category,
    required this.isPopular,
    required this.sendCount,
  });

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      coinsPrice: json['coinsPrice'] as int? ?? 10,
      gemsPrice: json['gemsPrice'] as int? ?? 0,
      animation: json['animation'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
      isPopular: json['isPopular'] as bool? ?? false,
      sendCount: json['sendCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'coinsPrice': coinsPrice,
      'gemsPrice': gemsPrice,
      'animation': animation,
      'category': category,
      'isPopular': isPopular,
      'sendCount': sendCount,
    };
  }
}
