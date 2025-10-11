enum ItemCategory{
  skin,
  weapon,
  pet,
  armor
}

enum ItemRarity{
  common,
  rare,
  epic,
  legendary
}

class AvatarItem {
  final String id;
  final String name;
  final ItemCategory itemCategory;
  final ItemRarity itemRarity;
  final int levelRequired;
  final int price;
  final String imageUrl;
  bool isAcquired = false;
  bool isEquipped = false;

  AvatarItem({
    required this.id,
    required this.name,
    required this.itemCategory,
    required this.itemRarity,
    required this.levelRequired,
    required this.price,
    required this.imageUrl,
    this.isAcquired = false,
    this.isEquipped = false
  });

  static fromJson(Map<String, dynamic> json) {
    return AvatarItem(
      id: json["id"],
      name: json["name"],
      itemCategory: json["ItemCategory"],
      itemRarity: json["ItemRarity"],
      levelRequired: json["levelRequired"],
      price: json["price"],
      imageUrl: json["imageUrl"],
      isAcquired: json["isAcquired"],
      isEquipped: json["isEquipped"]
    );
  }
}