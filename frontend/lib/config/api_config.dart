class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Products
  static String products       = '$baseUrl/products';
  static String productById(int id)   => '$baseUrl/products/$id';
  static String addProduct     = '$baseUrl/products/add';
  static String updateProduct(int id) => '$baseUrl/products/$id';
  static String deleteProduct(int id) => '$baseUrl/products/$id';

  // Cart
  static String getCart(int userId)   => '$baseUrl/cart/$userId';
  static String addToCart      = '$baseUrl/cart/add';
  static String updateCart     = '$baseUrl/cart/update';
  static String removeCartItem(int itemId) => '$baseUrl/cart/remove/$itemId';

  // Orders
  static String checkout       = '$baseUrl/orders/checkout';
}