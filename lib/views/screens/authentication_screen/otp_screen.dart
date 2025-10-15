import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Veify your Account',style: GoogleFonts.montserrat(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20,),
              Text('OTP has been sent to your email',style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              Text(widget.email,style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}