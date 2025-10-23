import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final Set<String> _selectedOrbits = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Orbits'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        actions: [
          if (_selectedOrbits.isNotEmpty)
            TextButton(
              onPressed: _shareSelectedOrbits,
              child: const Text(
                'Share',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
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
                        const Color(0xFF9C27B0).withOpacity(0.1),
                        const Color(0xFF673AB7).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF9C27B0).withOpacity(0.3),
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
                              color: const Color(0xFF9C27B0).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.share_rounded,
                              color: Color(0xFF9C27B0),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Share Your Halo Space',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9C27B0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Share your Desire Orbits with family and friends. Let them know what you love and surprise each other with thoughtful gifts!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Select Orbits
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Orbits to Share',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    if (currentProfile.orbits.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (_selectedOrbits.length == currentProfile.orbits.length) {
                              _selectedOrbits.clear();
                            } else {
                              _selectedOrbits.addAll(
                                currentProfile.orbits.map((orbit) => orbit.id),
                              );
                            }
                          });
                        },
                        child: Text(
                          _selectedOrbits.length == currentProfile.orbits.length
                              ? 'Deselect All'
                              : 'Select All',
                          style: const TextStyle(
                            color: Color(0xFF2196F3),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                if (currentProfile.orbits.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'No orbits to share yet.\nCreate some Desire Orbits first!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                else
                  ...currentProfile.orbits.map((orbit) {
                    final isSelected = _selectedOrbits.contains(orbit.id);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: CheckboxListTile(
                        value: isSelected,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _selectedOrbits.add(orbit.id);
                            } else {
                              _selectedOrbits.remove(orbit.id);
                            }
                          });
                        },
                        title: Row(
                          children: [
                            Text(orbit.icon, style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                orbit.name,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text('${orbit.products.length} items'),
                        secondary: orbit.products.isNotEmpty
                            ? SizedBox(
                                width: 50,
                                height: 50,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(orbit.products.first.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    if (orbit.products.length > 1)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2196F3),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '+${orbit.products.length - 1}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            : null,
                        activeColor: const Color(0xFF2196F3),
                      ),
                    );
                  }),

                if (_selectedOrbits.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  const Text(
                    'Share Via',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildShareOption(
                          'WhatsApp',
                          Icons.message,
                          const Color(0xFF25D366),
                          () => _shareVia('WhatsApp'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildShareOption(
                          'Email',
                          Icons.email,
                          const Color(0xFF1976D2),
                          () => _shareVia('Email'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildShareOption(
                          'SMS',
                          Icons.sms,
                          const Color(0xFF34B7F1),
                          () => _shareVia('SMS'),
                        ),
                      ),
                    ],
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
                            Icons.lightbulb_rounded,
                            color: const Color(0xFF2196F3),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Sharing Tips',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2196F3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Share birthday or holiday orbits with family\n'
                        '• Let friends know about your sustainable choices\n'
                        '• Create group orbits for special occasions\n'
                        '• Surprise loved ones with items from their orbits',
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

  Widget _buildShareOption(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareSelectedOrbits() {
    if (_selectedOrbits.isEmpty) return;

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
          children: [
            const Text(
              'Choose sharing method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(
                  'WhatsApp',
                  Icons.message,
                  const Color(0xFF25D366),
                  () => _shareVia('WhatsApp'),
                ),
                _buildShareOption(
                  'Email',
                  Icons.email,
                  const Color(0xFF1976D2),
                  () => _shareVia('Email'),
                ),
                _buildShareOption(
                  'SMS',
                  Icons.sms,
                  const Color(0xFF34B7F1),
                  () => _shareVia('SMS'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shareVia(String method) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Shared ${_selectedOrbits.length} orbit(s) via $method! ✨'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
    setState(() {
      _selectedOrbits.clear();
    });
  }
}
