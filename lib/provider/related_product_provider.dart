import 'package:cartify/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelatedProductProvider extends StateNotifier<List<Product>>{
  RelatedProductProvider() : super([]);
  // set the list of products
  void setProducts(List<Product> products){
    state = products;
  }
}

final relatedProductProvider = StateNotifierProvider<RelatedProductProvider, List<Product>>((ref) => RelatedProductProvider(),);