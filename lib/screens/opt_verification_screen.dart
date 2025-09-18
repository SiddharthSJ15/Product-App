import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_app/screens/home_screen.dart';
import 'package:product_app/screens/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:product_app/provider/auth_provider.dart';
import 'package:product_app/screens/name_screen.dart';
import 'package:product_app/constants/colors.dart';
import 'package:pinput/pinput.dart';

class OptVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OptVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OptVerificationScreen> createState() => _OptVerificationScreenState();
}

class _OptVerificationScreenState extends State<OptVerificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void verification() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (auth.newUser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NameScreen(phoneNumber: widget.phoneNumber),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 3),
                        blurRadius: 11,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'OTP VERIFICATION',
                style: GoogleFonts.oxygen(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Enter the OTP sent to ',
                    style: GoogleFonts.oxygen(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '- +91-${widget.phoneNumber}',
                    style: GoogleFonts.oxygen(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    'OTP is',
                    style: GoogleFonts.oxygen(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(' '),
                  Text(
                    '${auth.verifyResponse!.otp}',
                    style: GoogleFonts.oxygen(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // OTP input
              SizedBox(
                width: double.infinity,
                child: Pinput(
                  length: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  defaultPinTheme: PinTheme(
                    width: 75,
                    height: 64,
                    textStyle: GoogleFonts.oxygen(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 75,
                    height: 64,
                    textStyle: GoogleFonts.oxygen(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    width: 75,
                    height: 64,
                    textStyle: GoogleFonts.oxygen(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  showCursor: false,
                  onCompleted: (value) => verification(),
                ),
              ),

              const SizedBox(height: 16),

              Center(
                child: Text(
                  '00:120 Sec',
                  style: GoogleFonts.oxygen(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't receive code ? ",
                    style: GoogleFonts.oxygen(fontSize: 14, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle resend code
                    },
                    child: Text(
                      'Re-send',
                      style: GoogleFonts.oxygen(
                        fontSize: 14,
                        color: const Color(0xFF00FFB2),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.oxygen(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
