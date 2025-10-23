import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About HaloMind'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
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
                    'HaloMind',
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
              '🏠 The Family Shopping Story',
              'Picture this: Mom screenshots a beautiful dress while scrolling Instagram at midnight. Dad bookmarks a gadget during his lunch break. Little Tharu spots the perfect toy at a friend\'s house. Each family member discovers amazing things, but these precious moments of "I want this!" get lost in the digital noise. Families shop in silos, missing the magic of shared discovery.',
              Icons.error_outline_rounded,
              const Color(0xFFF44336),
            ),
            
            const SizedBox(height: 24),
            
            // The Solution Section
            _buildSection(
              '✨ Where Families Unite Through Dreams',
              'HaloMind transforms scattered wishes into shared adventures. Imagine creating a "Tharu\'s 9th Birthday" orbit where everyone contributes gift ideas. Or a "Family Vacation Dreams" space where each member adds their must-haves. We turn solo shopping into family storytelling, where every desire becomes a chance to surprise, delight, and connect with those you love most.',
              Icons.lightbulb_rounded,
              const Color(0xFF4CAF50),
            ),
            
            const SizedBox(height: 24),
            
            // How It Works
            const Text(
              'The HaloMind Family Journey',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            
            _buildHowItWorksStep(
              '📸 Capture Magic Moments',
              'See something that makes your heart skip? Capture it instantly! Screenshot while browsing, snap a photo of something in real life, or paste any shopping link. Your desires are safe in your personal Halo Space.',
              Icons.camera_alt_rounded,
            ),
            
            _buildHowItWorksStep(
              '🌟 Create Desire Orbits',
              'Turn wishes into beautiful collections! Create "Christmas Magic" for holiday dreams, "Birthday Surprises" for special celebrations, or "Sustainable Living" for eco-friendly finds. Each orbit tells a story of what matters to your family.',
              Icons.favorite_rounded,
            ),
            
            _buildHowItWorksStep(
              '💝 Share & Surprise',
              'The real magic happens when families connect! Share your orbits with loved ones, peek into each other\'s dreams, and become the family member who gives the most thoughtful gifts. Distance doesn\'t matter when hearts are connected through shared wishes.',
              Icons.share_rounded,
            ),
            
            _buildHowItWorksStep(
              '🌱 Choose with Love',
              'Every choice matters! See GreenRank scores to choose planet-friendly options, discover local artisans creating beautiful things, and make purchases that reflect your family\'s values. Shop with purpose, love with intention.',
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
              '🌟 Desire Orbits',
              'These aren\'t just lists - they\'re emotional treasure chests! Each orbit captures the excitement of "I found something amazing!" and transforms it into shared family moments of joy and anticipation.',
              Icons.favorite_rounded,
              const Color(0xFF2196F3),
            ),
            
            _buildFeatureCard(
              '👨‍👩‍👧‍👦 Family Connection',
              'Remember the joy of finding the perfect gift? Now multiply that by every family member! Share orbits, discover each other\'s dreams, and become the gift-giving hero who always knows exactly what will make someone smile.',
              Icons.family_restroom_rounded,
              const Color(0xFF9C27B0),
            ),
            
            _buildFeatureCard(
              '🌍 Mindful Choices',
              'Love your family AND the planet! Our GreenRank shows you which choices are kinder to Earth, helping you teach kids about conscious consumption while still fulfilling everyone\'s dreams.',
              Icons.eco_rounded,
              const Color(0xFF4CAF50),
            ),
            
            _buildFeatureCard(
              '🎨 Community Love',
              'Discover the magic of local creators! Find unique, handcrafted treasures that tell stories, support your neighbors, and give your family something truly special that no one else has.',
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
                    'We dream of family dinner conversations that start with "Look what I found for you!" We envision parents and children sharing excitement over discoveries, grandparents staying connected to grandkids\' interests, and siblings surprising each other with perfect gifts. Shopping becomes storytelling, desires become connections, and every purchase celebrates the love that binds families together.',
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
