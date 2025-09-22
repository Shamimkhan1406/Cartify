import 'package:cartify/models/favorite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  FavoriteNotifier() : super({});

  void addFavorite({
    required String productName,
    required double productPrice,
    required String category,
    required List<String> images,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String productId,
    required String description,
    required String fullName,
  }) {
    state[productId] = Favorite(
      productName: productName,
      productPrice: productPrice,
      category: category,
      images: images,
      vendorId: vendorId,
      productQuantity: productQuantity,
      quantity: quantity,
      productId: productId,
      description: description,
      fullName: fullName,
    );
    // Notify listeners about the state change
    state = {...state};
  }
  // method to remove a product from the favorite list
  void removeFavoriteItem(String productId){
    state.remove(productId);
    // notify listeners about the state change
    state = {...state};
  }

  // getter to retrieve the current Favorite items
  Map<String, Favorite> get getFavoriteItems => state;
}
// define a state notifier provider to expose an instance of FavoriteNotifier 
final favoriteProvider = StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>((ref) {
  return FavoriteNotifier();
});
