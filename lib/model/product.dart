class Product {
  int? id;
  String? name;
  String? brand;
  String? cpu;
  String? ram;
  String? storage;
  String? gpu;
  double? price;
  int? stock;
  String? image;
  String? created_at;
  String? updated_at;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.cpu,
    required this.ram,
    required this.storage,
    required this.gpu,
    required this.price,
    required this.stock,
    required this.image,
    required this.created_at,
    required this.updated_at,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      brand: json['brand'] ?? "",
      cpu: json['cpu'] ?? "",
      ram: json['ram'] ?? "",
      storage: json['storage'] ?? "",
      gpu: json['gpu'] ?? "",
      price: json['price'] != null
          ? (json['price'] as num).toDouble()
          : 0.0,
      stock: json['stock'] ?? 0, // ✅ FIXED
      image: json['image'] ?? "",
      created_at: json['created_at'] ?? "",
      updated_at: json['updated_at'] ?? "",
    );
  }
}
