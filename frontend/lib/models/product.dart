class Product {
  final int id;
  final String name;
  final String? description;
  final double price;
  final int stock;
  final String? category;
  final String? imageUrl;
  final int? vendorId;
  final String? vendorName;

  Product({
    required this.id, required this.name,
    this.description,
    required this.price, required this.stock,
    this.category, this.imageUrl,
    this.vendorId, this.vendorName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    price: (json['price'] as num).toDouble(),
    stock: json['stock'],
    category: json['category'],
    imageUrl: json['image_url'],
    vendorId: json['vendor_id'],
    vendorName: json['vendor_name'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'price': price,
    'stock': stock,
    'category': category,
    'image_url': imageUrl,
    'vendor_id': vendorId,
  };
}