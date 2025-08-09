import 'package:cartify/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: () async {
        await authController.signOutUser(context: context);
      }, child: Text("SignOut"))),
    );
  }
}
