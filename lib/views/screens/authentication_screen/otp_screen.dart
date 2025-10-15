import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> otpDigits = List.filled(6, '');
  Widget buildOtpTextField(int index) {
    return Container(
      width: 50,
      height: 55,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey),
        // borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && value.length == 1) {
            // save the digit to the list with the correct index
            otpDigits[index] = value;
            // move to the next text field if not the last one
            if (index < 5) {
              FocusScope.of(context).nextFocus();
            } else {
              //clear the value if input is removed
              otpDigits[index] = '';
            }
          }
        },
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
          fillColor: Colors.grey[200],
          filled: true,
        ),
        onFieldSubmitted: (value) {
          // trigger verification when the last digit is entered and form is valid
          // if (index == 5 && otpDigits.every((digit) => digit.isNotEmpty)) {
          //   String otp = otpDigits.join();
          // }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Veify your Account',
                  style: GoogleFonts.montserrat(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'OTP has been sent to your email',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.email,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) => buildOtpTextField(index)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
