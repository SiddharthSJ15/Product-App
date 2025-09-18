import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_app/screens/home_screen.dart';
import 'package:product_app/screens/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:product_app/provider/auth_provider.dart';

class NameScreen extends StatefulWidget {
  final String? phoneNumber;

  const NameScreen({super.key, this.phoneNumber});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _nameController = TextEditingController();

  void login() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final name = _nameController.text.trim();
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Name cannot be empty')));
      return;
    }

    if (_nameController.text.isNotEmpty) {
      final res = await auth.loginRegister(name);
      if (res) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Registration failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Full Name',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8E8E93),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
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
              const SizedBox(height: 26),
              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.only(bottom: 24),
                child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
