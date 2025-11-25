class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final int stock;
  final bool inStock;
  final double? rating;
  final List<String> features;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.stock,
    this.inStock = true,
    this.rating,
    this.features = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? json['image'] ?? '',
      stock: json['stock'] ?? 0,
      inStock: json['inStock'] ?? true,
      rating: json['rating']?.toDouble(),
      features: List<String>.from(json['features'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'stock': stock,
      'inStock': inStock,
      'rating': rating,
      'features': features,
    };
  }
}
