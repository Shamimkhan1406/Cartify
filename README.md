# 🛒 Cartify - Customer Mobile App

A feature-rich Flutter e-commerce application that provides a seamless shopping experience for customers. Part of the Cartify Full-Stack ecosystem, this mobile app enables users to browse products, manage shopping carts, make secure payments, and track orders in real-time.

## 🌟 Features

- **User Authentication**: Secure signup and login with JWT-based authentication
- **Product Discovery**: Browse products with advanced search, filtering, and category navigation
- **Smart Shopping Cart**: Real-time cart management with automatic price calculations
- **Secure Checkout**: Integrated Stripe payment gateway for safe and fast transactions
- **Order Tracking**: Monitor order status with real-time updates from processing to delivery
- **Wishlist & Favorites**: Save products for later with intuitive favorites management
- **Profile Management**: Manage addresses, payment methods, and view order history
- **Product Reviews**: Read and write reviews with rating system
- **Push Notifications**: Stay updated on order status and special offers
- **Multi-Category Shopping**: Explore products across various categories

## 🏗️ Architecture
```
┌─────────────────┐    HTTP/REST   ┌─────────────────┐   Database   ┌─────────────────┐
│  Flutter App    │ ◄──────────────► │  Node.js API    │ ◄────────────► │    MongoDB      │
│  (Customer)     │                 │   (Backend)     │               │    (Atlas)      │
└─────────────────┘                 └────────┬────────┘               └─────────────────┘
                                             │
                                   ┌─────────┴─────────┐
                                   │   3rd Party APIs   │
                                   │  Stripe, Cloudinary│
                                   └────────────────────┘
```

## 🚀 Technologies Used

### Frontend Framework
- **Flutter**: Cross-platform mobile development (iOS & Android)
- **Dart**: Programming language
- **Material Design**: Modern UI components

### State Management
- **Provider** / **GetX**: Efficient state management solution

### Networking
- **HTTP / Dio**: RESTful API communication
- **JSON Serialization**: Data parsing and handling

### Payment Integration
- **Stripe SDK**: Secure payment processing
- **Payment Cards**: Credit/Debit card support

### Image Handling
- **CachedNetworkImage**: Efficient image caching and loading
- **Cloudinary Integration**: Product image fetching

### Storage
- **SharedPreferences**: Local data persistence
- **Secure Storage**: Token and sensitive data storage

## 📦 Installation & Setup

### Prerequisites
- Flutter SDK 3.0+
- Android Studio / Xcode
- Git
- iOS Simulator / Android Emulator or Physical Device

### 1. Clone the Repository
```bash
git clone https://github.com/Shamimkhan1406/Cartify.git
cd Cartify
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Backend Configuration
Update the backend URL in `lib/constants/global_variables.dart`:
```dart
const String uri = 'http://<YOUR_BACKEND_IP>:3000';
// For Android Emulator: 'http://10.0.2.2:3000'
// For iOS Simulator: 'http://localhost:3000'
// For Physical Device: 'http://<YOUR_LOCAL_IP>:3000'
```

### 4. Stripe Configuration
Add your Stripe publishable key in the configuration file:
```dart
const String stripePublishableKey = 'pk_test_your_key_here';
```

### 5. Run the Application
```bash
# For Android
flutter run

# For iOS (Mac only)
cd ios && pod install && cd ..
flutter run

# For specific device
flutter devices
flutter run -d <device_id>
```

## 🎯 Usage

### First Time Setup
1. **Launch the App**: Open Cartify on your device
2. **Create Account**: Sign up with email and password
3. **Browse Products**: Explore categories and products
4. **Add to Cart**: Select products and add to shopping cart
5. **Checkout**: Complete purchase with Stripe payment
6. **Track Order**: Monitor delivery status in real-time

### Testing Payment
Use Stripe test cards for development:
- Card Number: `4242 4242 4242 4242`
- Expiry: Any future date
- CVC: Any 3 digits
- ZIP: Any 5 digits

## 📱 App Structure
```
Cartify/
├── 📱 lib/
│   ├── main.dart                    # App entry point
│   ├── constants/
│   │   └── global_variables.dart    # API URLs, colors, etc.
│   ├── models/                      # Data models
│   │   ├── user.dart
│   │   ├── product.dart
│   │   ├── order.dart
│   │   └── cart.dart
│   ├── providers/                   # State management
│   │   ├── user_provider.dart
│   │   └── cart_provider.dart
│   ├── features/
│   │   ├── auth/                    # Authentication screens
│   │   ├── home/                    # Home & product listing
│   │   ├── cart/                    # Shopping cart
│   │   ├── search/                  # Search functionality
│   │   ├── product_details/         # Product details screen
│   │   └── account/                 # User profile & orders
│   ├── common/                      # Reusable widgets
│   │   └── widgets/
│   └── services/                    # API services
│       ├── auth_service.dart
│       ├── product_service.dart
│       ├── cart_service.dart
│       └── order_service.dart
├── 📦 assets/
│   └── images/                      # App images & icons
├── 🔧 android/                      # Android configuration
├── 🍎 ios/                          # iOS configuration
├── 📋 pubspec.yaml                  # Dependencies
└── 📄 README.md                     # This file
```

## 🔌 API Endpoints Used

### Authentication
- `POST /api/signup` - User registration
- `POST /api/signin` - User login
- `POST /api/tokenIsValid` - Token validation

### Products
- `GET /api/products` - Get all products
- `GET /api/products/:id` - Get product details
- `GET /api/products/search/:query` - Search products
- `GET /api/products/category/:category` - Filter by category

### Cart & Orders
- `POST /api/add-to-cart` - Add product to cart
- `DELETE /api/remove-from-cart` - Remove from cart
- `POST /api/order` - Place order
- `GET /api/orders/me` - Get user orders

## 🤝 Related Repositories

This app is part of the Cartify ecosystem:
- **Backend API**: [cartify-backend](https://github.com/Shamimkhan1406/cartify-backend)
- **Admin Dashboard**: [cartify-web-admin](https://github.com/Shamimkhan1406/cartify-web-admin)
- **Vendor App**: [cartify-vendor-app](https://github.com/Shamimkhan1406/cartify-vendor-app)

## 🐛 Troubleshooting

### Common Issues

1. **Backend Connection Failed**
   - Verify backend server is running
   - Check the API URL in `global_variables.dart`
   - For Android emulator, use `10.0.2.2` instead of `localhost`

2. **Payment Not Working**
   - Ensure Stripe publishable key is correctly configured
   - Use test card numbers in development mode
   - Check internet connectivity

3. **Images Not Loading**
   - Verify Cloudinary integration in backend
   - Check network permissions in AndroidManifest.xml
   - Ensure image URLs are valid

4. **Build Errors**
```bash
   flutter clean
   flutter pub get
   flutter run
```

## 🚢 Deployment

### Android (APK)
```bash
flutter build apk --release
# APK location: build/app/outputs/flutter-apk/app-release.apk
```

### iOS (IPA)
```bash
flutter build ios --release
# Open Xcode and archive the app
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Stripe for secure payment processing
- MongoDB team for the database solution
- All contributors and testers

---

**Made with ❤️ for seamless shopping experiences**
