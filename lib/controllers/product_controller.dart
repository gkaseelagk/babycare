
import 'package:ecommerce/models/product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Adding hardcoded data
    products.addAll([
      Product(id: '1', name: 'Baby Diapers', price: 999.0, imageUrl: 'assets/pampers.jpg',description: 'High-quality diapers for babies with excellent absorbency and comfort.'),
      Product(id: '2', name: 'Baby Shampoo', price: 150.0, imageUrl: 'assets/shampoo1.jpg',description: 'Gentle baby shampoo with natural ingredients for sensitive skin'),
       Product(id: '3', name: 'Baby seater', price: 750.0, imageUrl: 'assets/baby_seater.jpg',description: 'A comfortable and safe seater designed for babies. Perfect for sitting up and exploring the world around them. Made with soft, breathable fabric and sturdy support'),
        Product(id: '4', name: 'Baby Bed', price: 1050.0, imageUrl: 'assets/baby_bed.jpg',description: 'A cozy and secure bed for your little one, designed to provide a restful sleep. Features a soft mattress, breathable fabric, and side rails for added safety'),

      Product(id: '5', name: 'Bibs', price: 50.0, imageUrl: 'assets/bibs.jpg',description: 'Soft and absorbent bibs to keep your baby clean during mealtime. Made from high-quality, washable fabric with adjustable closures for a perfect fit'),
       Product(id: '6', name: 'Baby hairBands', price: 150.0, imageUrl: 'assets/baby_hairbands.jpg',description: 'dorable and stretchy hairbands for your babys delicate hair. Made from soft, non-irritating materials and available in a variety of cute designs'),

      // Add more products as needed
       Product(id: '7', name: 'new born Wear', price: 1150.0, imageUrl: 'assets/newborn_wear.jpg',description: 'Comfortable and gentle clothing for newborns. Crafted from soft, breathable fabric to keep your baby cozy and happy. Includes onesies, sleepers, and more'),
     Product(id: '8', name: 'nail trimmer', price: 1200.0, imageUrl: 'assets/nail.jpg',description: 'A safe and easy-to-use nail trimmer for babies. Designed to trim tiny nails without causing discomfort. Includes a gentle filing tool for smooth edges'),
      Product(id: '9', name: 'toys', price: 150.0, imageUrl: 'assets/toys.jpg',description: 'Stimulating and engaging toys for babies, designed to promote sensory development and motor skills. Made from safe, non-toxic materials with various textures and colors'),
       Product(id: '10', name: 'moistur', price: 1150.0, imageUrl: 'assets/moistur.jpg',description: 'Gentle and nourishing moisturizer for your babys sensitive skin. Enriched with natural ingredients to keep the skin soft, hydrated, and protected'),
        Product(id: '11', name: 'cradle', price: 5150.0, imageUrl: 'assets/cradle.jpg',description: 'A classic cradle that gently rocks your baby to sleep. Made from sturdy materials with a soft mattress and safety features to ensure a secure and calming environment'),
         Product(id: '12', name: 'Feeding bottle', price: 1150.0, imageUrl: 'assets/feeding.jpg',description: 'Convenient and easy-to-clean feeding bottle with a natural-shaped nipple. Designed to mimic breastfeeding and reduce colic. Made from durable, BPA-free materials'),
      Product(id: '13', name: 'baby set', price: 3150.0, imageUrl: 'assets/baby_set.jpg',description: ('Our baby sets combine style with functionality, ensuring your baby is both comfortable and cute. Each piece is crafted with care, meeting the highest standards of quality and safety.')),
       Product(id: '14', name: 'wipes', price: 150.0, imageUrl: 'assets/wipes.jpg',description: 'Our baby wipes are designed with your baby’s comfort and hygiene in mind. The combination of softness, moisture, and gentle ingredients makes them a reliable choice for keeping your baby clean and comfortable throughout the day.'),

    ]);
  }
   Product findProductById(int id) {
    return products.firstWhere((product) => product.id == id);
  }
}