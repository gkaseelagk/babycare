import 'dart:ffi';

import 'package:ecommerce/controllers/checkout_controller.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatelessWidget {
  final Product product; // Assuming you have a Product model
  final int selectedQuantity; 
  

  CheckoutPage({required this.product,required this.selectedQuantity});
final CheckoutController checkoutController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Summary"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (checkoutController.isProcessingPayment.value) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Name: ${product.name}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Quantity: ${checkoutController.quantity.value}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Price: \$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Date: ${checkoutController.purchaseDate.value.toLocal()}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          await checkoutController.generateReceipt(
                            checkoutController.transactionId.value,
                            checkoutController.purchaseDate.value,
                            product.name,
                            checkoutController.quantity.value,
                            //product.quantity.value,
                            product.price,
                          );
                        },
                        child: Text('Download Receipt'),
                      ),
                      SizedBox(height: 20),
                      Text(
                        checkoutController.transactionStatus.value,
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
