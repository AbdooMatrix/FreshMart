class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String? phone;
  final String? address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.phone,
    this.address,
  });

  /// Convert JSON → User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'] ?? 'customer',
      phone: json['phone'],
      address: json['address'],
    );
  }

  /// Convert User → JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'phone': phone,
      'address': address,
    };
  }
}