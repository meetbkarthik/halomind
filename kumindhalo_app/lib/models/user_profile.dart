class UserProfile {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String profileImage;
  final List<DesireOrbit> orbits;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.profileImage,
    required this.orbits,
  });
}

class DesireOrbit {
  final String id;
  final String name;
  final String icon;
  final List<Product> products;
  final DateTime createdAt;

  DesireOrbit({
    required this.id,
    required this.name,
    required this.icon,
    required this.products,
    required this.createdAt,
  });
}

class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String brand;
  final String category;
  final bool isSustainable;
  final bool isLocalArtisan;
  final double greenRank;
  final String sourceUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.brand,
    required this.category,
    this.isSustainable = false,
    this.isLocalArtisan = false,
    this.greenRank = 0.0,
    this.sourceUrl = '',
  });
}

class GiftedHalo {
  final String id;
  final String orbitId;
  final String orbitName;
  final String orbitIcon;
  final List<Product> products;
  final String haloGifterId; // Person who can buy/fulfill the gift
  final String haloGifterName; // Name of person who can buy the gift
  final String haloWisherId; // Person who made the wishes (orbit owner)
  final DateTime giftedAt;
  final bool isViewed;

  GiftedHalo({
    required this.id,
    required this.orbitId,
    required this.orbitName,
    required this.orbitIcon,
    required this.products,
    required this.haloGifterId,
    required this.haloGifterName,
    required this.haloWisherId,
    required this.giftedAt,
    this.isViewed = false,
  });
}
