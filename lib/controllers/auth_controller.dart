import 'package:cartify/global_variables.dart';
import 'package:cartify/models/user.dart';
import 'package:cartify/provider/user_provider.dart';
import 'package:cartify/services/manage_http_response.dart';
import 'package:cartify/views/screens/authentication_screen/login_screen.dart';
import 'package:cartify/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

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
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          // set the headers for the request
          'Content-Type':
              'application/json; charset=UTF-8', // specify the content type to json
        },
      ); // convert the user object to json and send it to the server
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          // show a snackbar with the message
          showSnackBar(context, "account created successfully");
          // navigate to the main screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
      );
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
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          // set the headers for the request
          'Content-Type':
              'application/json; charset=UTF-8', // specify the content type to json
        },
      );
      // handle the response by calling the manageHttpResponse function
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          // access shared prefferences to save the token and user data storage
          SharedPreferences preferences = await SharedPreferences.getInstance();
          // Extract the authentication token from res body
          String token = jsonDecode(response.body)['token'];
          // strore the auth token in shared preferences
          await preferences.setString("auth_token", token);
          // encode the user data received from the backend as json
          final userJson = jsonEncode(jsonDecode(response.body)['user']);
          // update the app state with the user data using reverpod
          providerContainer.read(userProvider.notifier).setUser(userJson);
          // store the user data in shared preferences for future use
          await preferences.setString("user", userJson);

          // show a snackbar with the message
          showSnackBar(context, "logged in successfully");
          // navigate to the main screen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
        },
      );
    } catch (e) {
      print('Error during signin: $e');
      showSnackBar(context, "Signin failed: ${e.toString()}");
    }
  }

  // sign out user
  Future<void> signOutUser({required context}) async {
    try {
      // access shared prefferences to save the token and user data storage
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // remove the auth token from shared preferences
      await preferences.remove("auth_token");
      // remove the user data from shared preferences
      await preferences.remove("user");
      // clear the app state with the user data using reverpod
      providerContainer.read(userProvider.notifier).signOut();
      // navigate to the login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
      // show a snackbar with the message
      showSnackBar(context, "logged out successfully");
    } catch (e) {
      print('Error during signout: $e');
      showSnackBar(context, "Signout failed: ${e.toString()}");
    }
  }

  // update user's state city and locality
  Future<void> updateUserLocation({
    required context,
    required String id,
    required String state,
    required String city,
    required String locality,
  }) async{
    try {
      // make a PUT request to update the user location
      http.Response response = await http.put(Uri.parse('$uri/api/users/$id'),
      // encode the updated data the state city and locality as json
      body: jsonEncode({
        'state': state,
        'city': city,
        'locality': locality,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      );
      manageHttpResponse(response: response, context: context, onSuccess: () async {
        showSnackBar(context, "location updated successfully");
        // decode the response body to get the updated user data
        final updatedUser = jsonDecode(response.body);
        // access shared prefferences to save the updated user data
        SharedPreferences preferences = await SharedPreferences.getInstance();
        // encode the updated user data as json
        // this is to ensure that the user data is stored in the same format as before
        final userJson = jsonEncode(updatedUser);
        // update the app state with the updated user data using reverpod
        // this is to ensure that the user data is updated in the app state
        providerContainer.read(userProvider.notifier).setUser(userJson);
        // store the updated user data in shared preferences for future use
        // this allows the app to retrieve the updated user data even after the app is restarted
        await preferences.setString("user", userJson);
      });
    } catch (e) {
      print('Error updating user location: $e');
      showSnackBar(context, "Location update failed: ${e.toString()}");
    }
  }
}
