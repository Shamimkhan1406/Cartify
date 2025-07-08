import 'package:cartify/global_variables.dart';
import 'package:cartify/models/user.dart';
import 'package:cartify/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<void> signUpUser({
    required context,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: "",
        fullName: fullName,
        email: email,
        state: "",
        city: "",
        locality: "",
        password: password,
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
      body: user.toJson(),
        headers: <String, String>{
        // set the headers for the request
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type to json
          }
      ); // convert the user object to json and send it to the server
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, "account created successfully");
      });
    } catch (e) {
      //
    }
  }
}
