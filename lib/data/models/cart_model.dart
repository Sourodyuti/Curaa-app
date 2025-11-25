class CartModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double total;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List?)
          ?.map((item) => CartItem.fromJson(item))
          .toList() ?? [],
      total: (json['total'] ?? 0).toDouble(),
    );
  }

  double calculateTotal() {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}

class CartItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      imageUrl: json['imageUrl'] ?? json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
}
