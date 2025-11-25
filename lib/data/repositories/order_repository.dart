import '../services/api_service.dart';
import '../models/order_model.dart';
import '../../config/api_config.dart';

class OrderRepository {
  final ApiService _apiService;

  OrderRepository(this._apiService);

  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _apiService.get(ApiConfig.orders);
      final List<dynamic> data = response.data is List
          ? response.data
          : response.data['orders'] ?? [];

      return data.map((json) => OrderModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  Future<OrderModel> getOrderById(String id) async {
    try {
      final response = await _apiService.get('${ApiConfig.orders}/$id');
      return OrderModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch order: $e');
    }
  }

  Future<OrderModel> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _apiService.post(
        ApiConfig.orders,
        data: orderData,
      );
      return OrderModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }
}
