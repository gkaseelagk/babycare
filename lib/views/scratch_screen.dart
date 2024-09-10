import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/views/cart_page.dart';
import 'package:ecommerce/views/scratch_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScratchCardScreen extends StatelessWidget {
  final Product product;

  ScratchCardScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations!'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ScratchCardWidget(
          imageUrl: product.imageUrl,
          productName: product.name,
          onTap: () {
            // Add the product to the cart with Rs0 price
            final cartController = Get.find<CartController>();
            final cartItem = CartItem(
              id: product.id,
              name: product.name,
              price: 0.0, // Rs0
              imageUrl: product.imageUrl,
              quantity: 1,
            );
            cartController.addItem(cartItem);
            
            // Navigate to the cart page or show a success message
            Get.to(() => CartPage());
          },
        ),
      ),
    );
  }
}