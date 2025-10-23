import 'package:flutter/material.dart';
import '../screens/halo_space_screen.dart';
import '../screens/capture_screen.dart';
import '../screens/price_alerts_screen.dart';
import '../screens/share_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2196F3),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildQuickActionCard(
                context,
                'Your Halo Space',
                Icons.favorite_rounded,
                const Color(0xFF2196F3),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HaloSpaceScreen()),
                ),
              ),
              _buildQuickActionCard(
                context,
                'Add Manually',
                Icons.add_circle_rounded,
                const Color(0xFF4CAF50),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CaptureScreen()),
                ),
              ),
              _buildQuickActionCard(
                context,
                'Price Alerts',
                Icons.notifications_active_rounded,
                const Color(0xFFFF9800),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PriceAlertsScreen()),
                ),
              ),
              _buildQuickActionCard(
                context,
                'Share Orbits',
                Icons.share_rounded,
                const Color(0xFF9C27B0),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShareScreen()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
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
      ),
    );
  }
}
