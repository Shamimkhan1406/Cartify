import 'package:cartify/controllers/auth_controller.dart';
import 'package:cartify/views/screens/detail/screens/order_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: ElevatedButton(onPressed: () async {
            await authController.signOutUser(context: context);
          }, child: Text("SignOut"))),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()),);
          }, child: Text('My Orders'))
        ],
      ),
    );
  }
}
