import '../services/api_service.dart';
import '../models/cart_model.dart';
import '../../config/api_config.dart';

class CartRepository {
  final ApiService _apiService;

  CartRepository(this._apiService);

  Future<CartModel> getCart() async {
    try {
      final response = await _apiService.get(ApiConfig.cart);
      return CartModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch cart: $e');
    }
  }

  Future<CartModel> addToCart(String productId, int quantity) async {
    try {
      final response = await _apiService.post(
        ApiConfig.cart,
        data: {
          'productId': productId,
          'quantity': quantity,
        },
      );
      return CartModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<CartModel> updateCartItem(String productId, int quantity) async {
    try {
      final response = await _apiService.put(
        '${ApiConfig.cart}/$productId',
        data: {'quantity': quantity},
      );
      return CartModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update cart: $e');
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      await _apiService.delete('${ApiConfig.cart}/$productId');
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      await _apiService.delete(ApiConfig.cart);
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }
}
