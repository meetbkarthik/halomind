import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/data_service.dart';

class AppProvider extends ChangeNotifier {
  UserProfile? _currentProfile;
  List<UserProfile> _profiles = [];
  bool _isLoading = false;
  String _selectedCategory = 'All';
  bool _sustainableOnly = false;
  bool _localArtisanOnly = false;

  UserProfile? get currentProfile => _currentProfile;
  List<UserProfile> get profiles => _profiles;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  bool get sustainableOnly => _sustainableOnly;
  bool get localArtisanOnly => _localArtisanOnly;

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
      orbit.products.add(product);
      notifyListeners();
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
