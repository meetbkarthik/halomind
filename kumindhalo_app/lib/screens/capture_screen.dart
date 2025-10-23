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

  void _smartCapture() {
    _showSmartCaptureOptions();
  }

  void _showSmartCaptureOptions() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2196F3).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.camera_enhance_rounded,
                      color: Color(0xFF2196F3),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Smart Capture',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Choose how you\'d like to capture your inspiration',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              // Screenshot Option
              _buildCaptureOptionCard(
                'Take Screenshot',
                'Capture what\'s on your screen',
                Icons.screenshot_rounded,
                const Color(0xFF4CAF50),
                () => _handleScreenshot(),
              ),
              
              const SizedBox(height: 16),
              
              // Camera Option
              _buildCaptureOptionCard(
                'Open Camera',
                'Take a photo of the product',
                Icons.camera_alt_rounded,
                const Color(0xFF2196F3),
                () => _handleCamera(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaptureOptionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16),
          color: color.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
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
                      fontWeight: FontWeight.w600,
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
              color: color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _handleScreenshot() {
    Navigator.pop(context);
    _simulateProductDetection();
  }

  void _handleCamera() {
    Navigator.pop(context);
    _simulateProductDetection();
  }

  void _simulateProductDetection() async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate AI detection
    await Future.delayed(const Duration(seconds: 2));
    
    Navigator.pop(context); // Close loading

    // Show Gabby's Dollhouse product
    final gabbysProduct = Product(
      id: 'gabbys_dollhouse_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Gabby\'s Dollhouse Playset',
      description: 'Interactive dollhouse with Gabby and friends, perfect for imaginative play',
      imageUrl: 'assets/images/gabbys.jpg',
      price: 49.99,
      brand: 'DreamWorks',
      category: 'Toys',
      isSustainable: true,
      greenRank: 8.5,
    );
    
    _showProductDetectedDialog(gabbysProduct);
  }

  void _showProductDetectedDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF4CAF50),
                  size: 48,
                ),
              ),
              
              const SizedBox(height: 16),
              
              const Text(
                'Product Detected!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Product Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildProductImage(product.imageUrl),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Halo It Button
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width > 600 ? 200 : double.infinity,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width > 600 ? 200 : double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showAddToOrbitDialog(product);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Halo It!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                // Check if product already exists
                final existingProduct = orbit.products.where((p) => p.id == product.id).firstOrNull;
                if (existingProduct != null) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} is already in ${orbit.name}! 🔄'),
                      backgroundColor: const Color(0xFFFF9800),
                    ),
                  );
                  return;
                }
                
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

  Widget _buildProductImage(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 120,
          width: 120,
          color: Colors.grey[200],
          child: const Icon(Icons.image, color: Colors.grey),
        ),
      );
    } else {
      return Image.network(
        imageUrl,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 120,
          width: 120,
          color: Colors.grey[200],
          child: const Icon(Icons.image, color: Colors.grey),
        ),
      );
    }
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
