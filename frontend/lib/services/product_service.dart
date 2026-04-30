import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/product.dart';

class ProductService {
  /// GET /products  — list all products
  static Future<List<Product>> getAllProducts() async {
    final res = await http.get(Uri.parse(ApiConfig.products));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((j) => Product.fromJson(j)).toList();
    }
    throw Exception('Failed to load products (${res.statusCode})');
  }

  /// GET /products/{id}
  static Future<Product> getProductById(int id) async {
    final res = await http.get(Uri.parse(ApiConfig.productById(id)));
    if (res.statusCode == 200) {
      return Product.fromJson(jsonDecode(res.body));
    }
    throw Exception('Product not found');
  }

  /// POST /products/add
  static Future<Product> createProduct({
    required String name,
    String? description,
    required double price,
    required int stock,
    String? category,
    String? imageUrl,
  }) async {
    final res = await http.post(
      Uri.parse(ApiConfig.addProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'category': category,
        'image_url': imageUrl,
      }),
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      return Product.fromJson(jsonDecode(res.body));
    }
    throw Exception('Failed to create product: ${res.body}');
  }

  /// PUT /products/{id}
  static Future<Product> updateProduct(int id, Map<String, dynamic> updates) async {
    final res = await http.put(
      Uri.parse(ApiConfig.updateProduct(id)),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updates),
    );
    if (res.statusCode == 200) {
      return Product.fromJson(jsonDecode(res.body));
    }
    throw Exception('Failed to update product');
  }

  /// DELETE /products/{id}
  static Future<bool> deleteProduct(int id) async {
    final res = await http.delete(Uri.parse(ApiConfig.deleteProduct(id)));
    return res.statusCode == 200;
  }
}