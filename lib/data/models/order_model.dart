class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double total;
  final String status;
  final ShippingAddress shippingAddress;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.status,
    required this.shippingAddress,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ?? [],
      total: (json['total'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress'] ?? {}),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class OrderItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
    );
  }
}

class ShippingAddress {
  final String fullName;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String phone;

  ShippingAddress({
    required this.fullName,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phone,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      fullName: json['fullName'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
      'phone': phone,
    };
  }
}
