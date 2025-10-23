import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../providers/app_provider.dart';
import '../widgets/product_card.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _categories = [
    'All',
    'Fashion',
    'Electronics',
    'Home & Living',
    'Toys',
    'Sports',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: const Color(0xFF2196F3),
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Discover Together',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF2196F3),
                          const Color(0xFF03DAC6),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: const Color(0xFF2196F3),
                    unselectedLabelColor: Colors.grey[600],
                    indicatorColor: const Color(0xFF2196F3),
                    tabs: const [
                      Tab(text: 'For You'),
                      Tab(text: 'Trending'),
                      Tab(text: 'Sustainable'),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                              label: const Text('Sustainable Only'),
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
                              label: const Text('Local Artisan Only'),
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
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childCount: provider.getFilteredProducts().length,
                  itemBuilder: (context, index) {
                    final product = provider.getFilteredProducts()[index];
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
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
