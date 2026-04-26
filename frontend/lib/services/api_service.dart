import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  static final String _baseUrl = ApiConfig.baseUrl;

  static Future<http.Response> get(String endpoint) {
    return http.get(Uri.parse('$_baseUrl$endpoint'));
  }

  static Future<http.Response> post(String endpoint, Map body) {
    return http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }
  // PUT, DELETE similarly...
}