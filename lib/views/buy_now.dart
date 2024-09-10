import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/views/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyNowPage extends StatelessWidget {
  final Product product;
final RxInt selectedQuantity = 1.obs; 
  BuyNowPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Now',style: TextStyle(fontStyle: FontStyle.italic, // Italic text style
            fontSize: 24, // Optional: set font size
            fontWeight: FontWeight.bold,color: Colors.white),),
             backgroundColor: Colors.teal,
      ),
      body:
      // Padding(
  //padding: const EdgeInsets.all(8.0),
  //
  Padding(
        padding: const EdgeInsets.all(16.0),  child: Container(
    decoration: BoxDecoration(
      color: Colors.white, // Set the background color of the container
      borderRadius: BorderRadius.circular(20), // Set the border radius
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Optional: add a shadow
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    
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
              product.description, // Display description here
              style: TextStyle(fontSize: 16.0),
            ), Obx(() => Row(
              children: [
                Text('Quantity: ', style: TextStyle(fontSize: 16.0)),
                SizedBox(width: 10.0),
                DropdownButton<int>(
                  value: selectedQuantity.value,
                  items: List.generate(10, (index) => index + 1)
                      .map((quantity) => DropdownMenuItem<int>(
                            value: quantity,
                            child: Text(quantity.toString()),
                          ))
                      .toList(),
                  onChanged: (newQuantity) {
                    if (newQuantity != null) {
                      selectedQuantity.value = newQuantity;
                    }
                  },
                ),
              ],
            )),
            Spacer(),
          /*  ElevatedButton(
              onPressed: () {
                // Handle the buy now action, such as processing payment or placing an order
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Purchase Confirmation'),
                    content: Text('Are you sure you want to buy this product?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Process the purchase and navigate back
                          Navigator.pop(context); // Close the dialog
                            Get.to(() => CheckoutPage(product: product)); // Go back to the previous screen
                        },
                        child: Text('Confirm'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Buy Now'),
            ),*/ElevatedButton(
  onPressed: () {
    // Handle the buy now action, such as processing payment or placing an order
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Purchase Confirmation'),
        content: Text('Are you sure you want to buy this product?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Process the purchase and navigate to CheckoutPage with the selected details
              Navigator.pop(context); // Close the dialog
              Get.to(
                () => CheckoutPage(
                  product: product, // Pass product object
                  selectedQuantity: selectedQuantity.value, // Pass selected quantity
                ),
              );
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  },
  child: Text('Buy Now'),
)


  ],
        ),
      ),
    ));
  }
}