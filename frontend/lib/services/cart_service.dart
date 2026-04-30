import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/cart_item.dart';

class CartResponse {
  final int userId;
  final List<CartItem> items;
  final double total;
  CartResponse({required this.userId, required this.items, required this.total});

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    userId: json['user_id'],
    items: (json['items'] as List).map((e) => CartItem.fromJson(e)).toList(),
    total: (json['total'] as num).toDouble(),
  );
}

class CartService {
  /// GET /cart/{user_id}
  static Future<CartResponse> getCart(int userId) async {
    final res = await http.get(Uri.parse(ApiConfig.getCart(userId)));
    if (res.statusCode == 200) {
      return CartResponse.fromJson(jsonDecode(res.body));
    }
    throw Exception('Failed to load cart');
  }

  /// POST /cart/add
  static Future<void> addToCart({
    required int userId,
    required int productId,
    int quantity = 1,
  }) async {
    final res = await http.post(
      Uri.parse(ApiConfig.addToCart),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'product_id': productId,
        'quantity': quantity,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to add to cart: ${res.body}');
    }
  }

  /// PUT /cart/update
  static Future<void> updateQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    final res = await http.put(
      Uri.parse(ApiConfig.updateCart),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'cart_item_id': cartItemId,
        'quantity': quantity,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to update cart');
    }
  }

  /// DELETE /cart/remove/{item_id}
  static Future<void> removeItem(int itemId) async {
    final res = await http.delete(Uri.parse(ApiConfig.removeCartItem(itemId)));
    if (res.statusCode != 200) {
      throw Exception('Failed to remove item');
    }
  }
}