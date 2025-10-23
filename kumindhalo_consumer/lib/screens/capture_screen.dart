import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/app_provider.dart';
import '../models/user_profile.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  final _urlController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Inspiration'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How would you like to capture?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 24),
            
            // Smart Capture
            _buildCaptureOption(
              'Smart Capture',
              'Use camera to detect products',
              Icons.camera_alt_rounded,
              const Color(0xFF2196F3),
              _smartCapture,
            ),
            
            const SizedBox(height: 16),
            
            // URL Input
            _buildCaptureOption(
              'From URL',
              'Paste link from any shopping site',
              Icons.link_rounded,
              const Color(0xFF4CAF50),
              () => _showUrlDialog(),
            ),
            
            const SizedBox(height: 16),
            
            // Upload Image
            _buildCaptureOption(
              'Upload Image',
              'Choose from your gallery',
              Icons.photo_library_rounded,
              const Color(0xFFFF9800),
              _uploadImage,
            ),
            
            const SizedBox(height: 16),
            
            // Manual Entry
            _buildCaptureOption(
              'Manual Entry',
              'Add product details yourself',
              Icons.edit_rounded,
              const Color(0xFF9C27B0),
              () => _showManualEntryDialog(),
            ),
            
            const SizedBox(height: 32),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_rounded,
                        color: const Color(0xFF2196F3),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Pro Tip',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Take a screenshot while browsing products on Amazon, H&M, or any shopping app. KumindHalo will automatically detect it and offer to add it to your Halo Space!',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptureOption(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _smartCapture() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    
    if (image != null) {
      // Simulate AI detection
      await Future.delayed(const Duration(seconds: 2));
      
      final provider = Provider.of<AppProvider>(context, listen: false);
      final currentProfile = provider.currentProfile;
      
      if (currentProfile != null) {
        // Create a sample product based on current profile
        Product detectedProduct;
        
        if (currentProfile.age <= 12) {
          detectedProduct = Product(
            id: 'captured_${DateTime.now().millisecondsSinceEpoch}',
            name: 'Labubu Doll Collection',
            description: 'Adorable Labubu character doll detected from camera',
            imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300',
            price: 25.99,
            brand: 'Pop Mart',
            category: 'Toys',
            isSustainable: true,
            greenRank: 8.5,
          );
        } else {
          detectedProduct = Product(
            id: 'captured_${DateTime.now().millisecondsSinceEpoch}',
            name: 'Sustainable Fashion Item',
            description: 'Eco-friendly clothing item detected from camera',
            imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300',
            price: 49.99,
            brand: 'EcoFashion',
            category: 'Fashion',
            isSustainable: true,
            greenRank: 9.2,
          );
        }
        
        _showAddToOrbitDialog(detectedProduct);
      }
    }
  }

  void _uploadImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      // Simulate AI processing
      await Future.delayed(const Duration(seconds: 1));
      
      final detectedProduct = Product(
        id: 'uploaded_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Product from Image',
        description: 'Product detected from uploaded image',
        imageUrl: 'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=300',
        price: 39.99,
        brand: 'Unknown',
        category: 'Fashion',
        greenRank: 7.0,
      );
      
      _showAddToOrbitDialog(detectedProduct);
    }
  }

  void _showUrlDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add from URL'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                hintText: 'Paste product URL here',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processUrl(_urlController.text);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _processUrl(String url) async {
    if (url.isEmpty) return;
    
    // Simulate URL processing
    await Future.delayed(const Duration(seconds: 2));
    
    final detectedProduct = Product(
      id: 'url_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Product from URL',
      description: 'Product extracted from provided URL',
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300',
      price: 129.99,
      brand: 'Brand Name',
      category: 'Electronics',
      greenRank: 6.5,
    );
    
    _showAddToOrbitDialog(detectedProduct);
  }

  void _showManualEntryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manual Entry'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _createManualProduct();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _createManualProduct() {
    if (_nameController.text.isEmpty) return;
    
    final manualProduct = Product(
      id: 'manual_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text,
      description: _descriptionController.text.isEmpty 
          ? 'Manually added product' 
          : _descriptionController.text,
      imageUrl: 'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=300',
      price: double.tryParse(_priceController.text) ?? 0.0,
      brand: 'Custom',
      category: 'Other',
      greenRank: 5.0,
    );
    
    _showAddToOrbitDialog(manualProduct);
  }

  void _showAddToOrbitDialog(Product product) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final currentProfile = provider.currentProfile;
    
    if (currentProfile == null) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to Orbit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${product.name}'),
            const SizedBox(height: 16),
            const Text('Choose an orbit:'),
            const SizedBox(height: 8),
            ...currentProfile.orbits.map((orbit) => ListTile(
              leading: Text(orbit.icon, style: const TextStyle(fontSize: 20)),
              title: Text(orbit.name),
              onTap: () {
                provider.addProductToOrbit(orbit.id, product);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to ${orbit.name}! ✨'),
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
