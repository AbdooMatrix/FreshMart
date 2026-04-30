class CartItem {
  final int id;
  final int userId;
  final int productId;
  final int quantity;
  final String productName;
  final double productPrice;
  final double subtotal;
  final String? productImage;  // ⚠️ See backend tweak below

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productPrice,
    required this.subtotal,
    this.productImage,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    userId: json['user_id'],
    productId: json['product_id'],
    quantity: json['quantity'],
    productName: json['product_name'],
    productPrice: (json['product_price'] as num).toDouble(),
    subtotal: (json['subtotal'] as num).toDouble(),
    productImage: json['product_image'],   // null-safe if backend doesn't add it
  );
}