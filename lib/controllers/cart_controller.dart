
import 'package:ecommerce/models/cart.dart';
import 'package:get/get.dart';


class CartController extends GetxController {
  // Reactive cart items list
  var cartItems = <CartItem>[].obs;

  // Getter for cart items
  List<CartItem> get items => cartItems.toList();

  // Add item to cart
  void addItem(CartItem item) {
    final index = cartItems.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );
    } else {
      cartItems.add(item);
    }
  }

  // Remove item from cart
  void removeItem(String id) {
    cartItems.removeWhere((item) => item.id == id);
  }

  // Clear the cart
  void clear() {
    cartItems.clear();
  }

  // Get total item count
  int get itemCount => cartItems.fold(0, (total, item) => total + item.quantity);

  // Get total amount
  double get totalAmount => cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
}