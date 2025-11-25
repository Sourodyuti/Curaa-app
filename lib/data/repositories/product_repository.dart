import '../services/api_service.dart';
import '../models/product_model.dart';
import '../../config/api_config.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<ProductModel>> getProducts({
    String? category,
    String? search,
    int? page,
    int? limit,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;
      if (page != null) queryParams['page'] = page;
      if (limit != null) queryParams['limit'] = limit;

      final response = await _apiService.get(
        ApiConfig.products,
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data is List
          ? response.data
          : response.data['products'] ?? [];

      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _apiService.get('${ApiConfig.products}/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }
}
