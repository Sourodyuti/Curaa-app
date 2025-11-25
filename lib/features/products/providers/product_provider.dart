import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../models/product.dart';
import '../../auth/providers/auth_provider.dart';

// State class for Products
class ProductState {
  final List<Product> products;
  final bool isLoading;
  final String? error;

  ProductState({this.products = const [], this.isLoading = false, this.error});
}

class ProductNotifier extends Notifier<ProductState> {
  @override
  ProductState build() {
    // Load products immediately upon creation
    loadProducts();
    return ProductState(isLoading: true);
  }

  Future<void> loadProducts() async {
    try {
      final dio = ref.read(dioClientProvider).dio;
      final response = await dio.get(ApiConstants.products);

      // Backend returns { message: "...", products: [...] }
      final List<dynamic> rawList = response.data['products'];
      final products = rawList.map((e) => Product.fromJson(e)).toList();

      state = ProductState(products: products, isLoading: false);
    } catch (e) {
      state = ProductState(
        products: [],
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final productProvider = NotifierProvider<ProductNotifier, ProductState>(() {
  return ProductNotifier();
});