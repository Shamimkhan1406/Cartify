import 'dart:convert';

import 'package:cartify/models/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// a notifier class to manage the cart state extending StateNotifier
// with an initial empty map of cart items
class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({}){
    _loadCartItems();
  }

  // a private methode that loads items from shared pefference
  Future<void> _loadCartItems() async {
    // retrive the shared preferences instance
    final pref = await SharedPreferences.getInstance();
    // get the list of json strings from shared preferences
    final cartListString = pref.getString('cart_items');
    if (cartListString != null) {
      // decode the json string to a list of maps
      final Map<String, dynamic> cartList = jsonDecode(cartListString);
      // convert the dynamic map into a map of favorites object using the from json factory mathod
      final cartItems = cartList.map((key,value)=>MapEntry(key, Cart.fromJson(value)));
      // updating the state with loaded data
      state = cartItems;

    }
  }

  // a private method that saves the current list of cart items to shared preferences
  Future <void> _saveCartItems() async {
    //retrive the shared preferences instance
    final pref = await SharedPreferences.getInstance();
    // convert the current state of cart items to a list of json strings
    final cartList = jsonEncode(state);
    // save the list of json strings to shared preferences
    await pref.setString('cart_items', cartList);
  }

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
      _saveCartItems();
    }
    else{
      // if it doesn't exist, add it with the provided details
      state = {
        ...state,
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
      _saveCartItems();
    }
  }
  // method to increment the quantity of a product in the cart
  void incrementProductQuantity(String productId) {
    if (state.containsKey(productId)){
      state[productId]!.quantity++;
      // notify listeners about the state change
      state = {...state};
      _saveCartItems();
    }
  }
  // method to decrement the quantity of a product in the cart
  void decrementProductQuantity(String productId) {
    if (state.containsKey(productId)){
      // if the quantity becomes zero, remove the product from the cart
      if (state[productId]!.quantity == 1) {
        state.remove(productId);
      }
      else {
        // otherwise, just decrement the quantity
        state[productId]!.quantity--;
      }
      // notify listeners about the state change
      state = {...state};
      _saveCartItems();
    }
  }
  // method to remove a product from the cart
  void removeCartItem(String productId){
    state.remove(productId);
    // notify listeners about the state change
    state = {...state};
    _saveCartItems();
  }
  // method to calculate the total price of items in the cart
  double calculateTotalAmount(){
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.productPrice * cartItem.quantity;
    });
    return totalAmount;
  }
  // getter to retrieve the current cart items
  Map<String, Cart> get getCartItems => state;
}
// define a state notifier provider to expose an instance of CartNotifier 
final cartProvider = StateNotifierProvider<CartNotifier, Map<String, Cart>>((ref) {
  return CartNotifier();
});