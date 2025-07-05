import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'log in your account',
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
                fontSize: 23,
              ),
            ),
            Text(
              'to explore the world exclusives',
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
            Image.asset(
              'assets/images/Illustration.png',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
