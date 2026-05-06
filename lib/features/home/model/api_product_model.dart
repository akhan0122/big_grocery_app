class ApiProductModel {
  const ApiProductModel({
    required this.id,
    required this.title,
    required this.price,
  });

  final int id;
  final String title;
  final double price;

  factory ApiProductModel.fromJson(Map<String, dynamic> json) {
    return ApiProductModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );
  }
}
