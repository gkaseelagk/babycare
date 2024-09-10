
import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/views/otp_screen.dart';
import 'package:ecommerce/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 20),
                // Phone Number TextField with Icon
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Colors.teal),
                    labelText: 'Enter Phone Number',
                    labelStyle: TextStyle(color: Colors.teal),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.teal, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.teal, width: 2.5),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),
                // Sign In Button
                Obx(
                  () => authController.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          onPressed: () {
                            String phoneNumber = phoneController.text.trim();
                            if (phoneNumber.isNotEmpty) {
                              authController.sendOTP(phoneNumber);
                              Get.to(() => OTPScreen());
                            } else {
                              Get.snackbar("Error", "Please enter a valid phone number");
                            }
                          },
                          child: Text('Sign In', style: TextStyle(fontSize: 18)),
                        ),
                ),
                SizedBox(height: 20),
                // Register Here Link
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignupPage());
                  },
                  child: Text(
                    "Don't have an account? Register here",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
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
