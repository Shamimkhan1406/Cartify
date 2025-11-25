# 🛍️ Cartify - Customer Mobile App

A feature-rich Flutter e-commerce application that provides a seamless shopping experience. Part of the Cartify Full-Stack ecosystem, this app allows users to browse products, manage carts, and make secure payments.

## 🌟 Features

- **User Authentication**: Secure signup and login with JWT authentication
- **Product Discovery**: Advanced search, filtering, and category navigation
- **Smart Cart**: Real-time cart management and price calculation
- **Secure Checkout**: Integrated Stripe payment gateway for safe transactions
- **Order Tracking**: Real-time status updates on active orders
- **Favorites**: Wishlist functionality to save products for later
- **Profile Management**: Address book and order history management

## 🏗️ Architecture

```ascii
┌─────────────────┐    HTTP/REST    ┌─────────────────┐    Database   ┌─────────────────┐
│   Flutter App   │ ◄─────────────► │   Node.js API   │ ◄───────────► │     MongoDB     │
│   (Customer)    │                 │    (Backend)    │               │     (Atlas)     │
└─────────────────┘                 └────────┬────────┘               └─────────────────┘
                                             │
                                     ┌───────┴───────┐
                                     │  3rd Party    │
                                     │ Stripe/Cloud  │
                                     └───────────────┘
🚀 Technologies UsedFramework: Flutter (Dart)State Management: Provider / GetX (Adjust based on your code)Network: HTTP / DioPayments: Stripe SDKUI Components: Cupertino & Material DesignAsset Management: CachedNetworkImage📦 Installation & SetupPrerequisitesFlutter SDK 3.0+Android Studio / XcodeGit1. Clone the RepositoryBashgit clone [https://github.com/Shamimkhan1406/Cartify.git](https://github.com/Shamimkhan1406/Cartify.git)
cd Cartify
2. Install DependenciesBashflutter pub get
3. ConfigurationCreate a .env file (if applicable) or update lib/constants/global_variables.dart with your backend URL:Dartconst String uri = 'http://<YOUR_LOCAL_IP>:3000';
4. Run the AppBash# For Android
flutter run

# For iOS (Mac only)
cd ios && pod install && cd ..
flutter run
📱 ScreenshotsHome ScreenProduct DetailsCart & Checkout🤝 ContributingFork the repositoryCreate your feature branch (git checkout -b feature/AmazingFeature)Commit your changes (git commit -m 'Add some AmazingFeature')Push to the branch (git push origin feature/AmazingFeature)Open a Pull Request
