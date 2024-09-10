


import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/views/scratch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController otpController = TextEditingController();

final ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter OTP',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body:SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please enter the OTP sent to your phone number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),
            // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: TextField(
                        controller: otpController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '', // Hides the counter text
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(fontSize: 24),
                        onChanged: (value) {
                          // Move to the next field automatically
                          if (value.length == 1 && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  ));
                }),
              ),
              SizedBox(height: 20),
              // Verify Button
              Obx(
                () => authController.isLoading.value
                    ? CircularProgressIndicator()
                    :Column (children:[ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        onPressed: () {
                          authController.verifyOTP(otpController.text.trim());
                        },
                        child: Text(
                          'Verify OTP',
                          style: TextStyle(fontSize: 18),
                        ),
                        
                      ),
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Customize button color if needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    // Navigate to the scratch card page using GetX
                    final product=productController.products.first;
                    Get.to(() => ScratchCardScreen(product: product));
                  },
                  child: Text(
                    'Click to view scratch card',
                    style: TextStyle(fontSize: 18),
                  ),
                ), ],),),
              SizedBox(height: 20),
              // Status Message
              Obx(
                () => Text(
                  authController.authStatus.value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red, // Error color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
