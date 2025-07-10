import 'package:cartify/global_variables.dart';
import 'package:cartify/models/user.dart';
import 'package:cartify/services/manage_http_response.dart';
import 'package:cartify/views/screens/authentication_screen/login_screen.dart';
import 'package:cartify/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthController {
  // sign up user
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
        token: "",
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
      body: user.toJson(),
        headers: <String, String>{
        // set the headers for the request
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type to json
          }
      ); // convert the user object to json and send it to the server
      manageHttpResponse(response: response, context: context, onSuccess: (){
        // show a snackbar with the message
        showSnackBar(context, "account created successfully");
        // navigate to the main screen
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      });
    } catch (e) {
      print('Error during signup: $e');
      showSnackBar(context, "Signup failed: ${e.toString()}");
    }
  }
  // sign in user
  Future<void> signInUser({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            "email": email,
            "password": password
          },),
          headers: <String, String>{
            // set the headers for the request
            'Content-Type': 'application/json; charset=UTF-8', // specify the content type to json
          }
      );
      // handle the response by calling the manageHttpResponse function
      manageHttpResponse(response: response, context: context, onSuccess: (){
        // show a snackbar with the message
        showSnackBar(context, "logged in successfully");
        // navigate to the main screen
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainScreen()), (route)=> false);
      });
    } catch (e){
      print('Error during signin: $e');
      showSnackBar(context, "Signin failed: ${e.toString()}");
    }
  }

}

