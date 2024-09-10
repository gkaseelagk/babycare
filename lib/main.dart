import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/checkout_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/views/cart_page.dart';
import 'package:ecommerce/views/otp_screen.dart';
import 'package:ecommerce/views/product_details_page.dart';
import 'package:ecommerce/views/product_list_screen.dart';
import 'package:ecommerce/views/scratch_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() 
 async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  Get.put(AuthController()); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Baby Care Ecommerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(CartController());
        Get.put(ProductController());
        Get.put(CheckoutController());
         // Initialize CartController
      }),
      getPages: [
        GetPage(
          name: '/product/:id', // Route for product details
          page: (){  final productId = int.parse(Get.parameters['id']!);
            final product = Get.find<ProductController>().findProductById(productId);

            return ProductDetailsPage(product: product);
          },
        ),
        GetPage(
          name: '/cart', // Route for cart page
          page: () => CartPage(),
        ),
        GetPage(
          name: '/productList', // Route for product list screen
          page: () => ProductListScreen(),
        ),
         GetPage(
          name: '/otp', // Route for OTP page
          page: () => OTPScreen(),
        ),
       // GetPage(
         // name: '/phoneAuth', // Route for phone authentication
          //page: () => PhoneAuthScreen(),
        //11111111111111111111111111111111111111111111111111111111111111111111111111),
        GetPage(
          name: '/ScratchCardScreen', // Route for phone authentication
          
  page: () {
    final product = Get.find<ProductController>().products.first;
    return ScratchCardScreen(product: product);
  },


        ),
        // Add other routes here
      ],
     initialRoute: '/productList', // Set the initial route
      //initialRoute: '/cartPage', 
    );
  }
}