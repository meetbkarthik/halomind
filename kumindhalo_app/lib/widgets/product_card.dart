import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/user_profile.dart';
import '../providers/app_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(String orbitId) onAddToOrbit;
  final VoidCallback? onRemove;
  final VoidCallback? onClaim;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToOrbit,
    this.onRemove,
    this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product Image with badges overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: CachedNetworkImage(
                    imageUrl: '${product.imageUrl}?w=200&h=150&fit=crop',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 100,
                      color: Colors.grey[200],
                      child: const Center(
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 100,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 20),
                    ),
                    memCacheWidth: 200,
                    memCacheHeight: 150,
                  ),
                ),
              ),
              // Badges positioned at top-right of image
              Positioned(
                top: 4,
                right: 4,
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    if (product.isSustainable)
                      _buildBadge('Sustainable', const Color(0xFF4CAF50)),
                    if (product.isLocalArtisan)
                      _buildBadge('Local Artisan', const Color(0xFFFF9800)),
                  ],
                ),
              ),
            ],
          ),
          
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                // Product Name
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 2),
                
                // Brand
                Text(
                  product.brand,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Price and Green Rank
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                    if (product.greenRank > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: _getGreenRankColor(product.greenRank),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.eco_rounded,
                              size: 10,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 1),
                            Text(
                              product.greenRank.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Action Buttons
                if (onClaim != null) ...[
                  // Claim Button (for gifted halos)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onClaim,
                      icon: const Icon(Icons.shopping_cart_rounded, size: 14),
                      label: const Text(
                        'Claim & Buy',
                        style: TextStyle(fontSize: 10),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ] else if (onRemove != null) ...[
                  // Remove Button (for orbit detail view)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onRemove,
                      icon: const Icon(Icons.remove_circle_outline, size: 14),
                      label: const Text(
                        'Remove',
                        style: TextStyle(fontSize: 10),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  // Add to Orbit Button (for discover view)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showAddToOrbitDialog(context),
                      icon: const Icon(Icons.add_rounded, size: 14),
                      label: const Text(
                        'Add to Orbit',
                        style: TextStyle(fontSize: 10),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _getGreenRankColor(double rank) {
    if (rank >= 8.0) return const Color(0xFF4CAF50);
    if (rank >= 6.0) return const Color(0xFFFF9800);
    return const Color(0xFFF44336);
  }

  void _showAddToOrbitDialog(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final currentProfile = provider.currentProfile;
    
    if (currentProfile == null) return;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add "${product.name}" to:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            ...currentProfile.orbits.map((orbit) => ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(orbit.icon, style: const TextStyle(fontSize: 20)),
              ),
              title: Text(
                orbit.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('${orbit.products.length} items'),
              onTap: () {
                onAddToOrbit(orbit.id);
                Navigator.pop(context);
              },
            )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
