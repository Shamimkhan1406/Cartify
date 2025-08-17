import 'package:cartify/models/order.dart';
import 'package:cartify/services/manage_http_response.dart';
import 'package:http/http.dart' as http;
import '../global_variables.dart';


class OrderController {
  // function to upload order
  Future<void> uploadOrder({
  required String id,
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
      final Order order = Order(
        id: id,
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
}