import 'package:cartify/controllers/auth_controller.dart';
import 'package:cartify/views/screens/detail/screens/order_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 450,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/FBrbGWQJqIbpA5ZHEpajYAEh1V93%2Fuploads%2Fimages%2F78dbff80_1dfe_1db2_8fe9_13f5839e17c1_bg2.png?alt=media",
                      width: MediaQuery.of(context).size.width,
                      height: 451,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/icons/not.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment(0, -0.53),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png'),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.23, -0.61),
                        child: InkWell(
                          onTap: (){},
                          child: Image.asset(
                            'assets/icons/edit.png',
                            width: 19,
                            height: 19,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Center(child: ElevatedButton(onPressed: () async {
    //         await authController.signOutUser(context: context);
    //       }, child: Text("SignOut"))),
    //       ElevatedButton(onPressed: (){
    //         Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()),);
    //       }, child: Text('My Orders'))
    //     ],
    //   ),
    // );
  }
}
