import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About KumindHalo'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2196F3),
                    const Color(0xFF03DAC6),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'KumindHalo',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Where what you love finds its moment ✨',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // The Problem Section
            _buildSection(
              'The Challenge We Solve',
              'Today, families shop in silos. Mom discovers something beautiful on Instagram, Dad finds a gadget on Amazon, kids spot toys everywhere - but these desires remain scattered across apps, forgotten in countless wishlists.',
              Icons.problem_rounded,
              const Color(0xFFF44336),
            ),
            
            const SizedBox(height: 24),
            
            // The Solution Section
            _buildSection(
              'Our Beautiful Solution',
              'KumindHalo brings families together through shared discovery. Create Desire Orbits for every occasion - birthdays, festivals, dreams. Capture what inspires you, share with loved ones, and make mindful choices that celebrate both your desires and our planet.',
              Icons.lightbulb_rounded,
              const Color(0xFF4CAF50),
            ),
            
            const SizedBox(height: 24),
            
            // How It Works
            const Text(
              'How KumindHalo Works',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            _buildHowItWorksStep(
              '1. Capture',
              'Screenshot products while browsing, use Smart Capture with your camera, or paste URLs from any shopping site.',
              Icons.camera_alt_rounded,
            ),
            
            _buildHowItWorksStep(
              '2. Organize',
              'Create Desire Orbits for every occasion - Christmas gifts, birthday wishes, dream vacation items, or daily needs.',
              Icons.favorite_rounded,
            ),
            
            _buildHowItWorksStep(
              '3. Share',
              'Invite family members to your orbits. Surprise each other with thoughtful gifts and shop together, even when apart.',
              Icons.share_rounded,
            ),
            
            _buildHowItWorksStep(
              '4. Choose Wisely',
              'See GreenRank scores for sustainability, discover local artisans, and make choices that are good for you and the planet.',
              Icons.eco_rounded,
            ),
            
            const SizedBox(height: 32),
            
            // Key Features
            const Text(
              'What Makes Us Special',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            _buildFeatureCard(
              'Desire Orbits',
              'Not just wishlists - emotional collections that bring meaning to your shopping journey.',
              Icons.favorite_rounded,
              const Color(0xFF2196F3),
            ),
            
            _buildFeatureCard(
              'Family Sharing',
              'Transform solo shopping into shared experiences. Surprise loved ones with gifts they actually want.',
              Icons.family_restroom_rounded,
              const Color(0xFF9C27B0),
            ),
            
            _buildFeatureCard(
              'GreenRank Intelligence',
              'Every product gets a sustainability score. Choose items that are kind to our planet.',
              Icons.eco_rounded,
              const Color(0xFF4CAF50),
            ),
            
            _buildFeatureCard(
              'Local Artisan Discovery',
              'Find beautiful, unique items from local creators and support your community.',
              Icons.handyman_rounded,
              const Color(0xFFFF9800),
            ),
            
            const SizedBox(height: 32),
            
            // Vision Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF2196F3).withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Vision',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'We envision a world where shopping becomes a celebration of connection, consciousness, and care. Where families discover together, choose sustainably, and support local communities - all while making their desires come to life at just the right moment.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildHowItWorksStep(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF2196F3), size: 20),
          ),
          const SizedBox(width: 12),
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
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, String description, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
