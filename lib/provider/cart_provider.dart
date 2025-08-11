import 'package:cartify/models/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// a notifier class to manage the cart state extending StateNotifier
// with an initial empty map of cart items
class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});
  // method to add product to cart
  void addProductToCart({
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
    //check if the product already exists in the cart
    if (state.containsKey(productId)) {
      // if it exists, update the quantity
      state = {
        ...state,
        productId: Cart(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          category: state[productId]!.category,
          images: state[productId]!.images,
          vendorId: state[productId]!.vendorId,
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1,
          productId: state[productId]!.productId,
          description: state[productId]!.description,
          fullName: state[productId]!.fullName,
          
        ),
      };
    }
    else{
      // if it doesn't exist, add it with the provided details
      state = {
        productId: Cart(
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
        ),
      };
    }
  }
}
