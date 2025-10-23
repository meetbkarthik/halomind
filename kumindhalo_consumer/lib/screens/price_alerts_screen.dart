import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class PriceAlertsScreen extends StatefulWidget {
  const PriceAlertsScreen({super.key});

  @override
  State<PriceAlertsScreen> createState() => _PriceAlertsScreenState();
}

class _PriceAlertsScreenState extends State<PriceAlertsScreen> {
  String? _selectedOrbitId;
  final Set<String> _enabledAlerts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Alerts'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          final currentProfile = provider.currentProfile;
          if (currentProfile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFF9800).withOpacity(0.1),
                        const Color(0xFFF57C00).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFF9800).withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF9800).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.notifications_active_rounded,
                              color: Color(0xFFFF9800),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Price Flare Alerts',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9800),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Get notified when prices drop on items in your Desire Orbits. Never miss a great deal!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Select Orbit
                const Text(
                  'Choose Desire Orbit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),

                ...currentProfile.orbits.map((orbit) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: RadioListTile<String>(
                    value: orbit.id,
                    groupValue: _selectedOrbitId,
                    onChanged: (value) {
                      setState(() {
                        _selectedOrbitId = value;
                      });
                    },
                    title: Row(
                      children: [
                        Text(orbit.icon, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Text(
                          orbit.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    subtitle: Text('${orbit.products.length} items'),
                    activeColor: const Color(0xFF2196F3),
                  ),
                )),

                if (_selectedOrbitId != null) ...[
                  const SizedBox(height: 32),
                  const Text(
                    'Products in Selected Orbit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Builder(
                    builder: (context) {
                      final selectedOrbit = currentProfile.orbits
                          .firstWhere((orbit) => orbit.id == _selectedOrbitId);
                      
                      if (selectedOrbit.products.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'No products in this orbit yet.\nAdd some products to enable price alerts!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: selectedOrbit.products.map((product) {
                          final isEnabled = _enabledAlerts.contains(product.id);
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: SwitchListTile(
                              value: isEnabled,
                              onChanged: (value) {
                                setState(() {
                                  if (value) {
                                    _enabledAlerts.add(product.id);
                                  } else {
                                    _enabledAlerts.remove(product.id);
                                  }
                                });
                                
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value 
                                        ? 'Price alert enabled for ${product.name}! 🔔'
                                        : 'Price alert disabled for ${product.name}',
                                    ),
                                    backgroundColor: value 
                                      ? const Color(0xFF4CAF50) 
                                      : Colors.grey[600],
                                  ),
                                );
                              },
                              title: Text(
                                product.name,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('\$${product.price.toStringAsFixed(2)}'),
                                  if (isEnabled)
                                    Text(
                                      'Alert when price drops below \$${(product.price * 0.9).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF4CAF50),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              ),
                              secondary: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(product.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              activeColor: const Color(0xFF2196F3),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],

                const SizedBox(height: 32),

                // Info Section
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
                            Icons.info_outline_rounded,
                            color: const Color(0xFF2196F3),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'How Price Flare Works',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2196F3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• We monitor prices across multiple retailers\n'
                        '• Get notified when prices drop by 10% or more\n'
                        '• Receive alerts via push notifications\n'
                        '• Best deals are highlighted with sustainability scores',
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
          );
        },
      ),
    );
  }
}
