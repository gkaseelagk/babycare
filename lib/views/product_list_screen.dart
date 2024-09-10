
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/views/cart_page.dart';
import 'package:ecommerce/views/login_page.dart';
import 'package:ecommerce/views/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) { 
    
  return Scaffold(
    appBar: AppBar(
   //  title: Image.asset(
     //     'assets/images/logo.png', // Replace with your image path
       //   height: 40, // Set the height of the image
        
      //),// Set the height of the image
    title:   ClipRRect(
        borderRadius: BorderRadius.circular(20.0), // Adjust the radius for the circular effect
        child: Image.asset(
          'assets/icon.jpg', // Replace with your image path
          height: 40, // Set the height of the image
          width: 80,  // Set the width to match the height for a circular shape
          fit: BoxFit.cover, // Ensure the image covers the container properly
        ),
      ),


     backgroundColor: Colors.teal,
        actions: [
        Obx(() =>
          
        Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, size: 30.0),
                onPressed: () {
                  Get.to(() =>CartPage());
                  // Navigate to cart page or show cart
                },
              ),
              if (cartController.itemCount > 0)
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )),IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Handle login icon press
              // For example, navigate to the login screen
               Get.to(() => LoginPage());
            },
          ),
        ],
      ),
      body: Padding(
  padding: const EdgeInsets.all(16.0), // Padding around the entire page
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white, // Background color of the rounded container
      borderRadius: BorderRadius.circular(20.0), // Rounded corners
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0), // Padding inside the rounded container
      child: Obx(() {
        if (productController.products.isEmpty) {
          return const  Center(child: CircularProgressIndicator());
  
        }
        return GridView.builder(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 10.0, // Horizontal space between items
            mainAxisSpacing: 10.0, // Vertical space between items
            childAspectRatio: 0.75, // Aspect ratio of the items (width/height)
          ),
          padding:const EdgeInsets.all(10.0),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return 
           GestureDetector(
                    onTap: () {
                      Get.to(() => ProductDetailsPage(product: product));
                     //Get.to(()=>ScratchCardScreen);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners for images
                      child: 
            Stack(
            children: [
              // Image with asset
              Positioned.fill(
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
             
                 Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Cart icon with circular background
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    decoration:const BoxDecoration(
                      shape: BoxShape.circle,
                     color: Color.fromARGB(255, 255, 255, 255), // Background color of the icon
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                child: IconButton(
                  icon:const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: () {
                     //final product = productController.products.first;
   // Get.to(() => ScratchCardScreen(product: product));
                   // Get.to(() =>ScratchCardScreen());
                  // final product = productController.products[index];
                    // Add to cart action
                   Get.to(() =>CartPage());
                  },
                ),
              ),
            )],
          )));
          },
      );
      })))),
    );
  }
}
