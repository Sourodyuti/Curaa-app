import 'package:flutter/material.dart';
import '../data/models/order_model.dart';
import '../data/repositories/order_repository.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _orderRepository;

  List<OrderModel> _orders = [];
  OrderModel? _selectedOrder;
  bool _isLoading = false;
  String? _error;

  List<OrderModel> get orders => _orders;
  OrderModel? get selectedOrder => _selectedOrder;
  bool get isLoading => _isLoading;
  String? get error => _error;

  OrderProvider(this._orderRepository);

  Future<void> fetchOrders() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _orders = await _orderRepository.getOrders();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOrderById(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _selectedOrder = await _orderRepository.getOrderById(id);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    try {
      _error = null;
      await _orderRepository.createOrder(orderData);
      await fetchOrders();
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
