import 'dart:convert';

import 'package:cartify/models/category.dart';
import 'package:cartify/services/manage_http_response.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';

class CategoryController {

  // load the uploaded categories
  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/categories"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categories = data.map((category)=>Category.fromJson(category)).toList();
        return categories;
      }
      else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error loading categories: $e");
    }
  }
}
