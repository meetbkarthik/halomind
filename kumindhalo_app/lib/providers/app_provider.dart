import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/data_service.dart';

class AppProvider with ChangeNotifier {
  List<UserProfile> _profiles = [];
  UserProfile? _currentProfile;
  bool _isLoading = false;
  String _selectedCategory = 'All';
  bool _sustainableOnly = false;
  bool _localArtisanOnly = false;
  bool _isAuthenticated = false;
  String _haloSpaceName = 'My Halo Space';
  List<GiftedHalo> _giftedHalos = [];

  UserProfile? get currentProfile => _currentProfile;
  List<UserProfile> get profiles => _profiles;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  bool get sustainableOnly => _sustainableOnly;
  bool get localArtisanOnly => _localArtisanOnly;
  bool get isAuthenticated => _isAuthenticated;
  String get haloSpaceName => _haloSpaceName;
  // Halos where current user is the Halo Gifter (can buy gifts for others)
  List<GiftedHalo> get giftedHalos => _giftedHalos.where((halo) => halo.haloGifterId == _currentProfile?.id).toList();
  
  // Halos where current user is the Halo Wisher (shared their wishes)
  List<GiftedHalo> get sharedWishes => _giftedHalos.where((halo) => halo.haloWisherId == _currentProfile?.id).toList();

  AppProvider() {
    _initializeData();
  }

  void _initializeData() {
    _profiles = DataService.getProfiles();
    _currentProfile = _profiles.first; // Default to Tharu Karthik
    notifyListeners();
  }

  void switchProfile(String profileId) {
    _currentProfile = _profiles.firstWhere((p) => p.id == profileId);
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleSustainableOnly() {
    _sustainableOnly = !_sustainableOnly;
    if (_sustainableOnly) _localArtisanOnly = false;
    notifyListeners();
  }

  void toggleLocalArtisanOnly() {
    _localArtisanOnly = !_localArtisanOnly;
    if (_localArtisanOnly) _sustainableOnly = false;
    notifyListeners();
  }

  void addProductToOrbit(String orbitId, Product product) {
    if (_currentProfile != null) {
      final orbit = _currentProfile!.orbits.firstWhere((o) => o.id == orbitId);
      
      // Check if product already exists in orbit
      final existingProduct = orbit.products.where((p) => p.id == product.id).firstOrNull;
      if (existingProduct != null) {
        // Product already exists, don't add duplicate
        return;
      }
      
      orbit.products.add(product);
      notifyListeners();
    }
  }

  void removeProductFromOrbit(String orbitId, String productId) {
    if (_currentProfile != null) {
      try {
        print('Attempting to remove product $productId from orbit $orbitId');
        final orbitIndex = _currentProfile!.orbits.indexWhere((o) => o.id == orbitId);
        print('Found orbit at index: $orbitIndex');
        
        if (orbitIndex != -1) {
          final orbit = _currentProfile!.orbits[orbitIndex];
          print('Orbit has ${orbit.products.length} products');
          
          final productIndex = orbit.products.indexWhere((p) => p.id == productId);
          print('Found product at index: $productIndex');
          
          if (productIndex != -1) {
            final removedProduct = orbit.products.removeAt(productIndex);
            print('Successfully removed product: ${removedProduct.name}');
            print('Orbit now has ${orbit.products.length} products');
            notifyListeners();
          } else {
            print('Product not found in orbit');
          }
        } else {
          print('Orbit not found');
        }
      } catch (e) {
        print('Error removing product: $e');
      }
    } else {
      print('No current profile');
    }
  }

  void createNewOrbit(String name, String icon) {
    if (_currentProfile != null) {
      final newOrbit = DesireOrbit(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        icon: icon,
        products: [],
        createdAt: DateTime.now(),
      );
      _currentProfile!.orbits.add(newOrbit);
      notifyListeners();
    }
  }

  void setAuthenticated(bool authenticated) {
    _isAuthenticated = authenticated;
    notifyListeners();
  }

  void setHaloSpaceName(String name) {
    _haloSpaceName = name;
    notifyListeners();
  }

  // Halo Gifting System
  void shareHaloWithGifter(String orbitId, String gifterId) {
    if (_currentProfile == null) return;
    
    final orbit = _currentProfile!.orbits.firstWhere((o) => o.id == orbitId);
    final gifter = _profiles.firstWhere((p) => p.id == gifterId);
    
    print('Sharing orbit ${orbit.name} with ${gifter.name}');
    
    final giftedHalo = GiftedHalo(
      id: 'gifted_${DateTime.now().millisecondsSinceEpoch}',
      orbitId: orbit.id,
      orbitName: orbit.name,
      orbitIcon: orbit.icon,
      products: List.from(orbit.products),
      haloGifterId: gifterId, // Person who can buy/fulfill the gift
      haloGifterName: gifter.name, // Name of person who can buy the gift
      haloWisherId: _currentProfile!.id, // Person who made the wishes (orbit owner)
      giftedAt: DateTime.now(),
    );
    
    _giftedHalos.add(giftedHalo);
    print('Total gifted halos: ${_giftedHalos.length}');
    notifyListeners();
  }

  void markGiftedHaloAsViewed(String giftedHaloId) {
    final index = _giftedHalos.indexWhere((halo) => halo.id == giftedHaloId);
    if (index != -1) {
      _giftedHalos[index] = GiftedHalo(
        id: _giftedHalos[index].id,
        orbitId: _giftedHalos[index].orbitId,
        orbitName: _giftedHalos[index].orbitName,
        orbitIcon: _giftedHalos[index].orbitIcon,
        products: _giftedHalos[index].products,
        haloGifterId: _giftedHalos[index].haloGifterId,
        haloGifterName: _giftedHalos[index].haloGifterName,
        haloWisherId: _giftedHalos[index].haloWisherId,
        giftedAt: _giftedHalos[index].giftedAt,
        isViewed: true,
      );
      notifyListeners();
    }
  }

  List<UserProfile> getAvailableHaloGifters() {
    return _profiles.where((profile) => profile.id != _currentProfile?.id).toList();
  }

  void signOut() {
    _isAuthenticated = false;
    _haloSpaceName = 'My Halo Space';
    notifyListeners();
  }

  List<Product> getFilteredProducts() {
    List<Product> allProducts = [];
    for (var profile in _profiles) {
      for (var orbit in profile.orbits) {
        allProducts.addAll(orbit.products);
      }
    }

    // Add sample products from DataService
    allProducts.addAll(DataService.getSampleProducts());

    if (_selectedCategory != 'All') {
      allProducts = allProducts.where((p) => p.category == _selectedCategory).toList();
    }

    if (_sustainableOnly) {
      allProducts = allProducts.where((p) => p.isSustainable).toList();
    }

    if (_localArtisanOnly) {
      allProducts = allProducts.where((p) => p.isLocalArtisan).toList();
    }

    return allProducts;
  }
}
