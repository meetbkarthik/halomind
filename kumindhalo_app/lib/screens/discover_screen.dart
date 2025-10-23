import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../providers/app_provider.dart';
import '../widgets/product_card.dart';
import '../services/data_service.dart';
import '../models/user_profile.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedBrand = 'All';
  RangeValues _priceRange = const RangeValues(0, 200);
  bool _showFilters = false;

  final List<String> _categories = [
    'All',
    'Fashion',
    'Electronics',
    'Home & Garden',
    'Jewelry',
    'Toys',
    'Beauty',
    'Food',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Mindful Marketplace',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2196F3),
                        Color(0xFF1976D2),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.eco,
                      size: 50,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
            
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for products...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(_showFilters ? Icons.filter_list : Icons.tune),
                          onPressed: () {
                            setState(() {
                              _showFilters = !_showFilters;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                      },
                    ),
                    
                    // Advanced Filters
                    if (_showFilters) ...[
                      const SizedBox(height: 16),
                      _buildAdvancedFilters(),
                    ],
                  ],
                ),
              ),
            ),
            
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Filter Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: provider.toggleSustainableOnly,
                            icon: Icon(
                              provider.sustainableOnly
                                  ? Icons.check_circle
                                  : Icons.eco_rounded,
                            ),
                            label: const Text('Eco-Friendly'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: provider.sustainableOnly
                                  ? const Color(0xFF4CAF50)
                                  : Colors.grey[200],
                              foregroundColor: provider.sustainableOnly
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: provider.toggleLocalArtisanOnly,
                            icon: Icon(
                              provider.localArtisanOnly
                                  ? Icons.check_circle
                                  : Icons.handyman_rounded,
                            ),
                            label: const Text('Artisan Made'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: provider.localArtisanOnly
                                  ? const Color(0xFFFF9800)
                                  : Colors.grey[200],
                              foregroundColor: provider.localArtisanOnly
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Category Chips
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = provider.selectedCategory == category;
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(category),
                              selected: isSelected,
                              onSelected: (selected) {
                                provider.setCategory(category);
                              },
                              selectedColor: const Color(0xFF2196F3),
                              checkmarkColor: Colors.white,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: _getCrossAxisCount(context),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childCount: _getFilteredProducts(provider).length,
                itemBuilder: (context, index) {
                  final product = _getFilteredProducts(provider)[index];
                  return ProductCard(
                    product: product,
                    onAddToOrbit: (orbitId) {
                      provider.addProductToOrbit(orbitId, product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to orbit! ✨'),
                          backgroundColor: Color(0xFF4CAF50),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAdvancedFilters() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Advanced Filters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Brand Filter
            const Text('Brand', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedBrand,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: _getBrands().map((brand) {
                return DropdownMenuItem(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBrand = value ?? 'All';
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Price Range
            const Text('Price Range', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 200,
              divisions: 20,
              labels: RangeLabels(
                '\$${_priceRange.start.round()}',
                '\$${_priceRange.end.round()}',
              ),
              onChanged: (values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            Text(
              'Price: \$${_priceRange.start.round()} - \$${_priceRange.end.round()}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getBrands() {
    final products = DataService.getSampleProducts();
    final brands = products.map((p) => p.brand).toSet().toList();
    brands.sort();
    return ['All', ...brands];
  }

  List<Product> _getFilteredProducts(AppProvider provider) {
    List<Product> products = DataService.getSampleProducts();
    
    // Apply provider filters
    if (provider.sustainableOnly) {
      products = products.where((p) => p.isSustainable).toList();
    }
    if (provider.localArtisanOnly) {
      products = products.where((p) => p.isLocalArtisan).toList();
    }
    if (provider.selectedCategory != 'All') {
      products = products.where((p) => p.category == provider.selectedCategory).toList();
    }
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      products = products.where((p) {
        return p.name.toLowerCase().contains(_searchQuery) ||
               p.brand.toLowerCase().contains(_searchQuery) ||
               p.description.toLowerCase().contains(_searchQuery) ||
               p.category.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    
    // Apply brand filter
    if (_selectedBrand != 'All') {
      products = products.where((p) => p.brand == _selectedBrand).toList();
    }
    
    // Apply price range filter
    products = products.where((p) {
      return p.price >= _priceRange.start && p.price <= _priceRange.end;
    }).toList();
    
    return products;
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1400) return 5;
    if (width > 1000) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}
