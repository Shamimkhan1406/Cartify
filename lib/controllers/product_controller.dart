import 'dart:convert';

import 'package:cartify/global_variables.dart';
import 'package:cartify/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProducts() async {
    try {
      http.Response response = await http.get(Uri.parse('$uri/api/populer-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      // check the http response status code
      if (response.statusCode == 200){
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> products = data.map((product)=>Product.fromMap(product as Map<String, dynamic>)).toList();
        return products;

      }
      else{
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading popular products: $e');
      
    }
  }
  // method to load recommended products
  Future<List<Product>> loadRecommendedProducts() async {
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/recommended-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> products = data.map((product)=> Product.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      } else {
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load recommended products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading recommended products: $e');
      
    }
  }
}