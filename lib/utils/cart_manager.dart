import 'package:flutter/material.dart';
import 'package:demo/model/product_service.dart';

class CartManager extends ChangeNotifier {
  // Singleton pattern for CartManager
  static final CartManager _instance = CartManager._internal();
  final List<Map<String, dynamic>> _cart = []; // List to hold cart items

  CartManager._internal();

  factory CartManager() {
    return _instance;
  }

  /// Adds a product to the cart with the specified size and quantity.
  void addToCart(Product product,
      {required String size, required int quantity}) {
    if (quantity <= 0) return; // Ignore invalid quantities

    final existingIndex = _cart.indexWhere((item) =>
        item['product'].productId == product.productId &&
        item['product_size'] == size);

    if (existingIndex != -1) {
      _cart[existingIndex]['product_quantity'] += quantity;
    } else {
      _cart.add({
        'product': product,
        'product_size': size,
        'product_quantity': quantity,
      });
    }

    notifyListeners();
  }

  /// Removes a product from the cart based on its size.
  void removeFromCart(Product product, {required String size}) {
    _cart.removeWhere((item) =>
        item['product'].productId == product.productId &&
        item['product_size'] == size);
    notifyListeners();
  }

  void updateQuantity(Product product, String size, int newQuantity) {
    final itemIndex = _cart.indexWhere((item) =>
        item['product'].productId == product.productId &&
        item['product_size'] == size);

    if (itemIndex != -1) {
      if (newQuantity > 0) {
        _cart[itemIndex]['product_quantity'] = newQuantity;
      } else {
        // Remove item from cart if quantity is zero or less
        _cart.removeAt(itemIndex);
      }

      notifyListeners();
    }
  }

  /// Returns an unmodifiable list of cart items.
  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cart);

  /// Checks if a product with a specific size is in the cart.
  bool isInCart(Product product, {required String size}) {
    return _cart.any((item) =>
        item['product'].productId == product.productId &&
        item['product_size'] == size);
  }

  double get discount {
    return 10.0;
  }

  double get shipping {
    return 5.0;
  }

  String get discountCode {
    return 'CNPXSF';
  }

  /// Calculates the total price of all items in the cart.

  double get totalPrice {
    return _cart.fold(
      0.0,
      (sum, item) =>
          sum + (item['product'].discountPrice * item['product_quantity']),
    );
  }

  /// Calculates the total number of items in the cart.
  // int get totalItems {
  //   return _cart.fold(
  //       0, (int count, item) => count + (item['product_quantity'] as int));
  // }

  int get totalItems {
    return _cart.length;
  }

  /// Clears all items from the cart.
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
