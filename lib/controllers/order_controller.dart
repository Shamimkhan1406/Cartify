import 'dart:convert';

import 'package:cartify/models/order.dart';
import 'package:cartify/services/manage_http_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../global_variables.dart';


class OrderController {
  // function to upload order
  Future<void> uploadOrder({
  required String id,
  required String productId,
  required String fullName,
  required String email,
  required String state,
  required String city,
  required String locality,
  required String productName,
  required double productPrice,
  required int quantity,
  required String category,
  required String image,
  required String buyerId,
  required String vendorId,
  required bool processing,
  required bool delivered,
  required context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        print('auth_token is null. Cannot upload order.');
        showSnackBar(context, 'Authentication error. Please log in again.');
        return;
      }
      final Order order = Order(
        id: id,
        productId: productId,
        fullName: fullName,
        email: email,
        state: state,
        city: city,
        locality: locality,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
        category: category,
        image: image,
        buyerId: buyerId,
        vendorId: vendorId,
        processing: processing,
        delivered: delivered,
      );
      http.Response response = await http.post(Uri.parse('$uri/api/orders'),
      body: order.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'you have successfully placed the order');
      });
    } catch (e) {
      showSnackBar(context, 'Error uploading order: $e');
      print('Error uploading order: $e');
    }
  }
  // functions to get orders by buyer id
  Future<List<Order>> loadOrders({required String buyerId}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        print('auth_token is null. Cannot load orders.');
        return [];
      }
      // send http get request to the server
      http.Response response = await http.get(Uri.parse('$uri/api/orders/$buyerId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      );
    // check if the response is successful
      if (response.statusCode == 200) {
        // parse the response body into dynamic list 
        // this convert the json data into a format that can be used in dart
        List<dynamic> data = jsonDecode(response.body);
        // map the dhynamic list to list of order object using the from json factory method
        // this convert the lis to raw data into list of order object
        List<Order> orders = data.map((order) => Order.fromJson(order)).toList();
        return orders;
      } else {
        // throw an exception if the response is not successful
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error loading orders: $e');
    }
  }
  // delete order by id
  Future<void> deleteOrder({required String id, required context}) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token == null) {
        print('auth_token is null. Cannot delete order.');
        showSnackBar(context, 'Authentication error. Please log in again.');
        return;
      }
      
      http.Response response = await http.delete(Uri.parse('$uri/api/orders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'Order deleted successfully');
      });
    } catch (e) {
      showSnackBar(context, 'Error deleting order: $e');
      //print('Error deleting order: $e');
    }
  }
}