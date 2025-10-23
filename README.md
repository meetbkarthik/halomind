# HaloMind - KumindHalo Prototype

## Overview
HaloMind is a revolutionary shopping companion app that helps users capture what inspires them, organize it into Desire Orbits, and make mindful choices that are good for both the user and the planet.

## Features
- **Desire Orbits**: Personal collections for organizing products by themes (Birthday Wishes, Christmas Magic, etc.)
- **Smart Capture**: Take photos, paste URLs, upload images, or use screenshots to capture products
- **GreenRank**: Sustainability scoring system for products
- **Family Sharing**: Share orbits with family and friends
- **Local Artisan Support**: Discover and support local artisans
- **Price Alerts**: Get notified when products go on sale

## Project Structure
- `kumindhalo_app/` - Main Flutter application
- `kumindhalo_consumer/` - Consumer-focused Flutter app variant
- `appimages/` - Application images and assets

## Recent Updates (Oct 24, 2025)
✅ **Fixed Product Images**: Corrected all incorrect product images (e.g., Barbie Dreamhouse now shows proper dollhouse instead of cycle)
✅ **Improved UI Alignment**: Moved sustainable tags to top-right of product images for better horizontal alignment
✅ **Enhanced Welcome Screen**: Added Tharu thumbnail image below welcome text
✅ **Code Quality**: Fixed compilation errors and improved code structure

## Getting Started

### Prerequisites
- Flutter SDK (>=3.13.0)
- Dart SDK (>=3.1.0)

### Installation
1. Clone the repository
2. Navigate to the app directory: `cd kumindhalo_app`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

### Web Development
To run on web:
```bash
flutter run -d chrome --web-port=8080
```

## Technology Stack
- **Framework**: Flutter
- **State Management**: Provider
- **Image Caching**: cached_network_image
- **UI Components**: Material Design with custom styling
- **Web Support**: Flutter Web

## Contributing
This is a prototype application for Kumarionix's HaloMind product. All development follows the company's coding standards and design guidelines.

## License
Proprietary - Kumarionix Technologies

---
*"Where what you love finds its moment"* ✨
