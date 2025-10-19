import 'dart:convert';

import 'package:cartify/global_variables.dart';
import 'package:cartify/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/populer-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> products =
            data
                .map(
                  (product) => Product.fromMap(product as Map<String, dynamic>),
                )
                .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
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
      http.Response response = await http.get(
        Uri.parse("$uri/api/recommended-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> products =
            data
                .map(
                  (product) => Product.fromMap(product as Map<String, dynamic>),
                )
                .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load recommended products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading recommended products: $e');
    }
  }

  // fetch product by category
  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> products =
            data
                .map(
                  (product) => Product.fromMap(product as Map<String, dynamic>),
                )
                .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load recommended products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading products by category: $e');
    }
  }

  // display related product by subcategory
  Future<List<Product>> loadRelatedProductsBySubCategory(
    String productId,
  ) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-subcategory/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> relatedProducts =
            data
                .map(
                  (product) => Product.fromMap(product as Map<String, dynamic>),
                )
                .toList();
        return relatedProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load relatedProducts');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading relatedProducts by subcategory: $e');
    }
  }

  // load product by subcategory
  Future<List<Product>> loadProductsBySubCategory(String subCategory) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/producs-by-subcategory/$subCategory'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> relatedProducts =
            data
                .map(
                  (product) => Product.fromMap(product as Map<String, dynamic>),
                )
                .toList();
        return relatedProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load SubCategory Products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading SubCategory Products by subcategory: $e');
    }
  }

  // method to fetch top 10 highest rated products
  Future<List<Product>> loadTopRatedProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/top-rated-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> topRatedProduct =
            data
                .map(
                  (product) => Product.fromMap(product as Map<String, dynamic>),
                )
                .toList();
        return topRatedProduct;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load top rated products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading top rated products: $e');
    }
  }

  // method to search for product by name or description
  Future<List<Product>> searchProducts(String query) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/search-products?query=$query'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> searchedProducts =
            data
                .map(
                  (product) => Product.fromMap(product as Map<String, dynamic>),
                )
                .toList();
        return searchedProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load searched Products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading searched Products : $e');
    }
  }

  // load product by subcategory
  Future<List<Product>> loadVendorProduct(String vendorId) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products/$vendorId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // check the http response status code
      if (response.statusCode == 200) {
        // decode the json response body into list of dynamic objects type
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        // map the list of dynamic objects to a list of Product objects
        List<Product> vendorsProducts =
            data
                .map(
                  (product) => Product.fromMap(product as Map<String, dynamic>),
                )
                .toList();
        return vendorsProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        // if the response status code is not 200, throw an error
        throw Exception('Failed to load vendors Products');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error loading vendors Products: $e');
    }
  }
}
