class OrderItemModel {
  final int productId;
  final String productName;
  final int quantity;
  final double priceAtPurchase;

  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.priceAtPurchase,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
    productId: json['product_id'],
    productName: json['product_name'],
    quantity: json['quantity'],
    priceAtPurchase: (json['price_at_purchase'] as num).toDouble(),
  );
}

class OrderModel {
  final int id;
  final int userId;
  final double totalAmount;
  final String status;
  final String paymentMethod;
  final String? shippingAddress;
  final String createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    this.shippingAddress,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'],
    userId: json['user_id'],
    totalAmount: (json['total_amount'] as num).toDouble(),
    status: json['status'],
    paymentMethod: json['payment_method'],
    shippingAddress: json['shipping_address'],
    createdAt: json['created_at'].toString(),
    items: (json['items'] as List)
        .map((e) => OrderItemModel.fromJson(e))
        .toList(),
  );
}