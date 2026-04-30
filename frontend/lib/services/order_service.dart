import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/order.dart';

class OrderService {
  /// POST /orders/checkout
  static Future<OrderModel> checkout({
    required int userId,
    String? shippingAddress,
    String paymentMethod = 'COD',
  }) async {
    final res = await http.post(
      Uri.parse(ApiConfig.checkout),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'shipping_address': shippingAddress,
        'payment_method': paymentMethod,
      }),
    );
    if (res.statusCode == 200) {
      return OrderModel.fromJson(jsonDecode(res.body));
    }
    // Backend returns 400 with detail message (e.g. "Cart is empty")
    final body = jsonDecode(res.body);
    throw Exception(body['detail'] ?? 'Checkout failed');
  }
}