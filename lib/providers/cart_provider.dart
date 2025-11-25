import 'package:flutter/material.dart';
import '../data/models/cart_model.dart';
import '../data/repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _cartRepository;

  CartModel? _cart;
  bool _isLoading = false;
  String? _error;

  CartModel? get cart => _cart;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get itemCount => _cart?.items.length ?? 0;
  double get total => _cart?.calculateTotal() ?? 0.0;

  CartProvider(this._cartRepository);

  Future<void> fetchCart() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _cart = await _cartRepository.getCart();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToCart(String productId, int quantity) async {
    try {
      _error = null;
      _cart = await _cartRepository.addToCart(productId, quantity);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateQuantity(String productId, int quantity) async {
    try {
      _error = null;
      _cart = await _cartRepository.updateCartItem(productId, quantity);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFromCart(String productId) async {
    try {
      _error = null;
      await _cartRepository.removeFromCart(productId);
      await fetchCart();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartRepository.clearCart();
      _cart = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
