import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _productRepository;

  List<ProductModel> _products = [];
  List<ProductModel> _featuredProducts = [];
  ProductModel? _selectedProduct;
  bool _isLoading = false;
  String? _error;

  // Filters
  String _selectedCategory = 'all';
  String _searchQuery = '';
  String _sortBy = 'featured';

  List<ProductModel> get products => _products;
  List<ProductModel> get featuredProducts => _featuredProducts;
  ProductModel? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  ProductProvider(this._productRepository);

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _products = await _productRepository.getProducts(
        category: _selectedCategory != 'all' ? _selectedCategory : null,
        search: _searchQuery.isNotEmpty ? _searchQuery : null,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      final allProducts = await _productRepository.getProducts(limit: 8);
      _featuredProducts = allProducts.take(8).toList();
      notifyListeners();
    } catch (e) {
      // Handle silently for featured products
    }
  }

  Future<void> fetchProductById(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _selectedProduct = await _productRepository.getProductById(id);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    fetchProducts();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    fetchProducts();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    _sortProducts();
    notifyListeners();
  }

  void _sortProducts() {
    switch (_sortBy) {
      case 'price_low':
        _products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        _products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'name':
        _products.sort((a, b) => a.name.compareTo(b.name));
        break;
      default:
      // featured - no sorting
        break;
    }
  }
}
