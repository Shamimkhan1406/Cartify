import 'dart:convert';

import 'package:cartify/models/favorite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  FavoriteNotifier() : super({}){
    _loadFavorites();
  }
  // a private methode that loads items from shared pefference
  Future<void> _loadFavorites() async {
    // retrive the shared preferences instance
    final pref = await SharedPreferences.getInstance();
    // get the list of json strings from shared preferences
    final favoriteListString = pref.getString('favorite');
    if (favoriteListString != null) {
      // decode the json string to a list of maps
      final Map<String, dynamic> favoriteList = jsonDecode(favoriteListString);
      // convert the dynamic map into a map of favorites object using the from json factory mathod
      final favorites = favoriteList.map((key,value)=>MapEntry(key, Favorite.fromJson(value)));
      // updating the state with loaded data
      state = favorites;

    }
  }

  // a private method that saves the current list of favorite items to shared preferences
  Future <void> _saveFavorites() async {
    //retrive the shared preferences instance
    final pref = await SharedPreferences.getInstance();
    // convert the current state of favorite items to a list of json strings
    final favoriteList = jsonEncode(state);
    // save the list of json strings to shared preferences
    await pref.setString('favorite', favoriteList);
  }
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
    _saveFavorites();
  }
  // method to remove a product from the favorite list
  void removeFavoriteItem(String productId){
    state.remove(productId);
    // notify listeners about the state change
    state = {...state};
    _saveFavorites();
  }

  // getter to retrieve the current Favorite items
  Map<String, Favorite> get getFavoriteItems => state;
}
// define a state notifier provider to expose an instance of FavoriteNotifier 
final favoriteProvider = StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>((ref) {
  return FavoriteNotifier();
});
