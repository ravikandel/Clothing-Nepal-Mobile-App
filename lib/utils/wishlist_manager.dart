import 'package:flutter/material.dart';
import 'package:demo/model/product_service.dart';

class WishlistManager extends ChangeNotifier {
  static final WishlistManager _instance = WishlistManager._internal();
  final List<Product> _wishlist = [];

  WishlistManager._internal();

  factory WishlistManager() {
    return _instance;
  }

  void addToWishlist(Product product) {
    if (!_wishlist.any((p) => p.productId == product.productId)) {
      _wishlist.add(product);
      notifyListeners(); // Notify listeners of the change
    }
  }

  void removeFromWishlist(Product product) {
    _wishlist.removeWhere((p) => p.productId == product.productId);
    notifyListeners(); // Notify listeners of the change
  }

  List<Product> get wishlist => List.unmodifiable(_wishlist);

  bool isInWishlist(Product product) {
    return _wishlist.any((p) => p.productId == product.productId);
  }

  /// Calculates the total number of items in the wishlist.
  int get totalItems {
    return _wishlist.length; // Return the number of items in the wishlist
  }
}
