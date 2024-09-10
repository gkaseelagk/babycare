
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/views/buy_now.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
 final CartController cartController = Get.find();
 //final RxInt selectedQuantity = 1.obs; 
  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name,style: TextStyle(fontStyle: FontStyle.italic, // Italic text style
            fontSize: 24, // Optional: set font size
            fontWeight: FontWeight.bold,color: Colors.white),),
             backgroundColor: Colors.teal,
         actions: [
          Obx(() => Stack(
            children: [
              IconButton(
                icon:const Icon(Icons.shopping_cart, size: 30.0),
                onPressed: () {
                  // Navigate to cart page or show cart
                },
              ),
              if (cartController.itemCount> 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        cartController.itemCount.toString(),
                        style:const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                product.imageUrl,
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              product.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20.0, color: Colors.green),
            ),
            SizedBox(height: 20.0),
            Text(
              product.description,
              style: TextStyle(fontSize: 16.0),
            ),
            
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () { Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyNowPage(product: product),
                        ),
                      );
                      // Handle Buy Now action
                    },
                    child: Text('Buy Now'),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle Add to Cart action
                        cartController.addItem( CartItem(
                          id: product.id,
                          name: product.name,
                          price: product.price,
                          imageUrl: product.imageUrl,
                          //description: product.description,
                        ),);
                          showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Added to Cart'),
                          content: Text('${product.name} has been added to your cart successfully.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back(); // Close the dialog
                                Get.toNamed('/cart'); // Navigate to the cart page
                              },
                              child: Text('Go to Cart'),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back(); // Close the dialog
                              },
                              child: Text('Continue Shopping'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}