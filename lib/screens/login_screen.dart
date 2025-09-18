import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _phoneController.text.isNotEmpty;
    });
  }

  void _onContinuePressed() {
    if (_phoneController.text.isNotEmpty) {
      // Handle login logic here
      debugPrint('Phone number: +91${_phoneController.text}');
    }
  }

  void _onTermsPressed() {
    // Handle terms of use navigation
    debugPrint('Terms of Use pressed');
  }

  void _onPrivacyPressed() {
    // Handle privacy policy navigation
    debugPrint('Privacy Policy pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              0,
              24,
              MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 64),

                // Title
                Text(
                  'Login',
                  style: GoogleFonts.oxygen(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                Text(
                  'Let\'s Connect with Lorem Ipsum..!',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8E8E93),
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 40),

                // Phone Input Field
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      // Country Code
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: const Text(
                          '+91',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Phone Number Input
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter Phone',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF8E8E93),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Continue Button
                Container(
                  width: double.infinity,
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled ? _onContinuePressed : null,
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Terms and Privacy
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8E8E93),
                        height: 1.4,
                      ),
                      children: [
                        const TextSpan(
                          text: 'By Continuing you accepting the ',
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: _onTermsPressed,
                            child: const Text(
                              'Terms of Use',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(text: ' & '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: _onPrivacyPressed,
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
