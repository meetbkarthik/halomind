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
            imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300',
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
            imageUrl: 'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?w=300',
            price: 199.99,
            brand: 'Mattel',
            category: 'Toys',
            greenRank: 6.0,
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
            imageUrl: 'https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=300',
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
      Product(
        id: 'sample1',
        name: 'Eco-Friendly Water Bottle',
        description: 'Sustainable stainless steel water bottle',
        imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=300',
        price: 24.99,
        brand: 'EcoLife',
        category: 'Home & Living',
        isSustainable: true,
        greenRank: 9.2,
      ),
      Product(
        id: 'sample2',
        name: 'Handmade Wooden Toy',
        description: 'Traditional wooden toy made by local artisans',
        imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300',
        price: 19.99,
        brand: 'Artisan Toys',
        category: 'Toys',
        isSustainable: true,
        isLocalArtisan: true,
        greenRank: 9.8,
      ),
      Product(
        id: 'sample3',
        name: 'Organic Cotton T-Shirt',
        description: 'Soft organic cotton t-shirt in various colors',
        imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300',
        price: 29.99,
        brand: 'Green Fashion',
        category: 'Fashion',
        isSustainable: true,
        greenRank: 8.7,
      ),
      Product(
        id: 'sample4',
        name: 'Solar Power Bank',
        description: 'Portable solar-powered charging device',
        imageUrl: 'https://images.unsplash.com/photo-1609592806787-3d9c5a0c3b7e?w=300',
        price: 49.99,
        brand: 'SolarTech',
        category: 'Electronics',
        isSustainable: true,
        greenRank: 9.0,
      ),
    ];
  }

  static List<Map<String, dynamic>> getKumbotResponses() {
    return [
      {
        'question': 'What is KumindHalo?',
        'answer': 'KumindHalo is your personal shopping companion that helps you capture what inspires you, organize it into Desire Orbits, and make mindful choices that are good for you and the planet! ✨'
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
