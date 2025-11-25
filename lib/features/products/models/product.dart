class Product {
  final String id;
  final String name;
  final String description;
  final double price; // Parsed as double
  final int stock;
  final String category;
  final List<String> images;
  final double rating;
  final int reviews;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.images,
    this.rating = 0.0,
    this.reviews = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse price which might come as String or Number
    double parsePrice(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return Product(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown Product',
      description: json['description'] ?? '',
      price: parsePrice(json['price']),
      stock: json['stock'] is int ? json['stock'] : int.tryParse(json['stock'].toString()) ?? 0,
      category: json['category'] ?? 'General',
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      rating: (json['rating'] is num) ? (json['rating'] as num).toDouble() : 0.0,
      reviews: json['review'] ?? 0, // Backend sends 'review' (singular) based on schema
    );
  }
}