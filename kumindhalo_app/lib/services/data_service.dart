import '../models/user_profile.dart';

class DataService {
  static List<UserProfile> getProfiles() {
    return [
      UserProfile(
        id: 'tharu',
        name: 'Tharu Karthik',
        age: 8,
        gender: 'Female',
        profileImage: 'assets/profiles/tharuprofile.png',
        orbits: _getTharuOrbits(),
      ),
      UserProfile(
        id: 'priya',
        name: 'Priya Karthik',
        age: 32,
        gender: 'Female',
        profileImage: 'assets/profiles/priya.png',
        orbits: _getPriyaOrbits(),
      ),
      UserProfile(
        id: 'nik',
        name: 'Nik Karthik',
        age: 12,
        gender: 'Male',
        profileImage: 'assets/profiles/nik.png',
        orbits: _getNikOrbits(),
      ),
      UserProfile(
        id: 'bala',
        name: 'Bala Karthik Baskaran',
        age: 41,
        gender: 'Male',
        profileImage: 'assets/profiles/bala.png',
        orbits: _getBalaOrbits(),
      ),
    ];
  }

  static List<DesireOrbit> _getTharuOrbits() {
    return [
      DesireOrbit(
        id: 'tharu_birthday',
        name: 'Birthday Wishes',
        icon: '🎂',
        products: [
          Product(
            id: 'labubu1',
            name: 'Labubu Doll Pink',
            description: 'Adorable Labubu character doll in pink',
            imageUrl: 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=300',
            price: 25.99,
            brand: 'Pop Mart',
            category: 'Toys',
            isSustainable: true,
            greenRank: 8.5,
          ),
          Product(
            id: 'barbie1',
            name: 'Barbie Dreamhouse',
            description: 'Three-story Barbie Dreamhouse with elevator',
            imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300',
            price: 199.99,
            brand: 'Mattel',
            category: 'Toys',
            greenRank: 6.0,
          ),
          Product(
            id: 'rubiks1',
            name: 'Rubik\'s Cube 3x3',
            description: 'Classic 3x3 Rubik\'s Cube puzzle toy',
            imageUrl: 'https://images.unsplash.com/photo-1606092195730-5d7b9af1efc5?w=300',
            price: 12.99,
            brand: 'Rubik\'s',
            category: 'Toys',
            greenRank: 7.5,
          ),
        ],
        createdAt: DateTime.now(),
      ),
      DesireOrbit(
        id: 'tharu_christmas',
        name: 'Christmas Magic',
        icon: '🎄',
        products: [
          Product(
            id: 'gabby1',
            name: 'Gabby\'s Dollhouse Playset',
            description: 'Interactive dollhouse with Gabby and friends',
            imageUrl: 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=300',
            price: 89.99,
            brand: 'Spin Master',
            category: 'Toys',
            greenRank: 7.0,
          ),
        ],
        createdAt: DateTime.now(),
      ),
      DesireOrbit(
        id: 'tharu_fashion',
        name: 'Princess Style',
        icon: '👗',
        products: [
          Product(
            id: 'dress1',
            name: 'Unicorn Princess Dress',
            description: 'Sparkly unicorn-themed dress for special occasions',
            imageUrl: 'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=300',
            price: 34.99,
            brand: 'Little Princess',
            category: 'Fashion',
            isSustainable: true,
            isLocalArtisan: true,
            greenRank: 9.0,
          ),
        ],
        createdAt: DateTime.now(),
      ),
    ];
  }

  static List<DesireOrbit> _getPriyaOrbits() {
    return [
      DesireOrbit(
        id: 'priya_fashion',
        name: 'Fashion Forward',
        icon: '👠',
        products: [
          Product(
            id: 'saree1',
            name: 'Handwoven Silk Saree',
            description: 'Traditional handwoven silk saree with gold border',
            imageUrl: 'https://images.unsplash.com/photo-1583391733956-6c78276477e2?w=300',
            price: 299.99,
            brand: 'Artisan Collective',
            category: 'Fashion',
            isSustainable: true,
            isLocalArtisan: true,
            greenRank: 9.5,
          ),
        ],
        createdAt: DateTime.now(),
      ),
      DesireOrbit(
        id: 'priya_home',
        name: 'Home & Living',
        icon: '🏠',
        products: [
          Product(
            id: 'vase1',
            name: 'Ceramic Flower Vase',
            description: 'Handcrafted ceramic vase with floral patterns',
            imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=300',
            price: 45.99,
            brand: 'Local Pottery',
            category: 'Home & Living',
            isSustainable: true,
            isLocalArtisan: true,
            greenRank: 8.8,
          ),
        ],
        createdAt: DateTime.now(),
      ),
    ];
  }

  static List<DesireOrbit> _getNikOrbits() {
    return [
      DesireOrbit(
        id: 'nik_gaming',
        name: 'Gaming Zone',
        icon: '🎮',
        products: [
          Product(
            id: 'controller1',
            name: 'Wireless Gaming Controller',
            description: 'High-performance wireless controller for gaming',
            imageUrl: 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?w=300',
            price: 79.99,
            brand: 'GameTech',
            category: 'Electronics',
            greenRank: 6.5,
          ),
        ],
        createdAt: DateTime.now(),
      ),
      DesireOrbit(
        id: 'nik_sports',
        name: 'Sports & Adventure',
        icon: '⚽',
        products: [
          Product(
            id: 'football1',
            name: 'Professional Football',
            description: 'FIFA approved professional football',
            imageUrl: 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=300',
            price: 29.99,
            brand: 'SportsPro',
            category: 'Sports',
            isSustainable: true,
            greenRank: 8.0,
          ),
        ],
        createdAt: DateTime.now(),
      ),
    ];
  }

  static List<DesireOrbit> _getBalaOrbits() {
    return [
      DesireOrbit(
        id: 'bala_tech',
        name: 'Tech Essentials',
        icon: '💻',
        products: [
          Product(
            id: 'laptop1',
            name: 'MacBook Pro 16"',
            description: 'Latest MacBook Pro with M3 chip',
            imageUrl: 'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=300',
            price: 2499.99,
            brand: 'Apple',
            category: 'Electronics',
            greenRank: 7.5,
          ),
        ],
        createdAt: DateTime.now(),
      ),
      DesireOrbit(
        id: 'bala_fitness',
        name: 'Fitness Journey',
        icon: '💪',
        products: [
          Product(
            id: 'watch1',
            name: 'Fitness Smartwatch',
            description: 'Advanced fitness tracking smartwatch',
            imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300',
            price: 399.99,
            brand: 'FitTech',
            category: 'Electronics',
            isSustainable: true,
            greenRank: 8.2,
          ),
        ],
        createdAt: DateTime.now(),
      ),
    ];
  }

  static List<Product> getSampleProducts() {
    return [
      // Sustainable Electronics
      Product(
        id: '1',
        name: 'Bamboo Wireless Headphones',
        brand: 'EcoSound',
        price: 89.99,
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
        category: 'Electronics',
        greenRank: 9.1,
        isSustainable: true,
        isLocalArtisan: false,
        description: 'Premium bamboo wireless headphones with recyclable components',
      ),
      Product(
        id: '2',
        name: 'Solar Bluetooth Speaker',
        brand: 'GreenTech',
        price: 65.99,
        imageUrl: 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=400',
        category: 'Electronics',
        greenRank: 8.7,
        isSustainable: true,
        isLocalArtisan: false,
        description: 'Solar-powered Bluetooth speaker with recycled materials',
      ),
      
      // Local Artisan Fashion
      Product(
        id: '3',
        name: 'Hand-woven Silk Scarf',
        brand: 'Village Weavers',
        price: 45.99,
        imageUrl: 'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=400',
        category: 'Fashion',
        greenRank: 9.5,
        isSustainable: true,
        isLocalArtisan: true,
        description: 'Exquisite hand-woven silk scarf by local artisans',
      ),
      Product(
        id: '4',
        name: 'Organic Cotton Kurta',
        brand: 'Heritage Crafts',
        price: 78.99,
        imageUrl: 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=400',
        category: 'Fashion',
        greenRank: 9.2,
        isSustainable: true,
        isLocalArtisan: true,
        description: 'Traditional organic cotton kurta with hand-block prints',
      ),
      Product(
        id: '5',
        name: 'Handcrafted Leather Bag',
        brand: 'Artisan Leather Co',
        price: 125.99,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
        category: 'Fashion',
        greenRank: 8.3,
        isSustainable: false,
        isLocalArtisan: true,
        description: 'Premium handcrafted leather bag by skilled artisans',
      ),
      
      // Sustainable Home & Garden
      Product(
        id: '6',
        name: 'Bamboo Dinnerware Set',
        brand: 'EcoHome',
        price: 34.99,
        imageUrl: 'https://images.unsplash.com/photo-1584464491033-06628f3a6b7b?w=400',
        category: 'Home & Garden',
        greenRank: 9.0,
        isSustainable: true,
        isLocalArtisan: false,
        description: 'Complete bamboo dinnerware set, biodegradable and stylish',
      ),
      Product(
        id: '7',
        name: 'Handmade Pottery Vase',
        brand: 'Clay Masters',
        price: 42.99,
        imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400',
        category: 'Home & Garden',
        greenRank: 9.3,
        isSustainable: true,
        isLocalArtisan: true,
        description: 'Beautiful handmade pottery vase with natural glazes',
      ),
      Product(
        id: '8',
        name: 'Organic Herb Garden Kit',
        brand: 'GreenThumb',
        price: 28.99,
        imageUrl: 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400',
        category: 'Home & Garden',
        greenRank: 9.7,
        isSustainable: true,
        isLocalArtisan: false,
        description: 'Complete organic herb garden starter kit with seeds',
      ),
      
      // Local Artisan Jewelry & Accessories
      Product(
        id: '9',
        name: 'Silver Filigree Earrings',
        brand: 'Traditional Jewelers',
        price: 89.99,
        imageUrl: 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=400',
        category: 'Jewelry',
        greenRank: 7.8,
        isSustainable: false,
        isLocalArtisan: true,
        description: 'Intricate silver filigree earrings by master craftsmen',
      ),
      Product(
        id: '10',
        name: 'Wooden Watch',
        brand: 'Forest Time',
        price: 95.99,
        imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400',
        category: 'Jewelry',
        greenRank: 8.9,
        isSustainable: true,
        isLocalArtisan: true,
        description: 'Handcrafted wooden watch from sustainable forests',
      ),
      
      // Kids Sustainable Products
      Product(
        id: '11',
        name: 'Wooden Building Blocks',
        brand: 'EcoToys',
        price: 32.99,
        imageUrl: 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400',
        category: 'Toys',
        greenRank: 9.4,
        isSustainable: true,
        isLocalArtisan: true,
        description: 'Natural wooden building blocks, safe and educational',
      ),
      Product(
        id: '12',
        name: 'Organic Cotton Stuffed Animal',
        brand: 'Cuddle Craft',
        price: 24.99,
        imageUrl: 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400',
        category: 'Toys',
        greenRank: 9.1,
        isSustainable: true,
        isLocalArtisan: true,
        description: 'Soft organic cotton stuffed animal, handmade with love',
      ),
      
      // Beauty & Personal Care
      Product(
        id: '13',
        name: 'Ayurvedic Face Cream',
        brand: 'Nature\'s Glow',
        price: 38.99,
        imageUrl: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400',
        category: 'Beauty',
        greenRank: 9.6,
        isSustainable: true,
        isLocalArtisan: true,
        description: 'Traditional Ayurvedic face cream with natural ingredients',
      ),
      Product(
        id: '14',
        name: 'Bamboo Toothbrush Set',
        brand: 'EcoDental',
        price: 15.99,
        imageUrl: 'https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?w=400',
        category: 'Beauty',
        greenRank: 9.8,
        isSustainable: true,
        isLocalArtisan: false,
        description: 'Biodegradable bamboo toothbrush family pack',
      ),
      
      // Food & Beverages
      Product(
        id: '15',
        name: 'Organic Spice Collection',
        brand: 'Spice Garden',
        price: 52.99,
        imageUrl: 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=400',
        category: 'Food',
        greenRank: 9.3,
        isSustainable: true,
        isLocalArtisan: true,
        description: 'Premium organic spice collection from local farmers',
      ),
    ];
  }

  static List<Map<String, dynamic>> getKumbotResponses() {
    return [
      {
        'question': 'What is HaloMind?',
        'answer': 'HaloMind is your personal shopping companion that helps you capture what inspires you, organize it into Desire Orbits, and make mindful choices that are good for you and the planet! ✨'
      },
      {
        'question': 'How do Desire Orbits work?',
        'answer': 'Desire Orbits are your personal collections! Create orbits like "Birthday Wishes" or "Christmas Magic" and add products you love. Share them with family to make shopping together magical! 🌟'
      },
      {
        'question': 'What is GreenRank?',
        'answer': 'GreenRank shows how sustainable a product is! Higher scores mean better for our planet - considering things like carbon footprint, local sourcing, and durability. Choose green, choose wisely! 🌱'
      },
      {
        'question': 'How can I capture products?',
        'answer': 'You can capture products in many ways: take photos with Smart Capture, paste URLs from websites, upload images from your gallery, or even take screenshots - Halo will detect them automatically! 📸'
      },
      {
        'question': 'Can I share my orbits with family?',
        'answer': 'Absolutely! Share your Desire Orbits with family and friends through WhatsApp, email, or SMS. Make shopping a family adventure and surprise each other with thoughtful gifts! 💝'
      },
    ];
  }
}
