// lib/features/home/data/models/product_model.dart

class ProductModel {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String weight; // "1.50 lbs"
  final bool isNew; // shows "NEW" badge
  final bool isFavorite; // heart icon state
  final String? discountLabel; // future: "20% OFF" badge
  final double? originalPrice; // future: strikethrough price

  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.weight,
    this.isNew = false,
    this.isFavorite = false,
    this.discountLabel,
    this.originalPrice,
  });

  // WHY copyWith: never mutate original object
  // creates NEW object with changed fields
  // GetX .obs works best with immutable models
  ProductModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    double? price,
    String? weight,
    bool? isNew,
    bool? isFavorite,
    String? discountLabel,
    double? originalPrice,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      isNew: isNew ?? this.isNew,
      isFavorite: isFavorite ?? this.isFavorite,
      discountLabel: discountLabel ?? this.discountLabel,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }

  // WHY fromJson: when you connect real API later
  // just change this one method — rest of app untouched
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      price: (json['price'] as num).toDouble(),
      weight: json['weight'] as String,
      isNew: json['is_new'] as bool? ?? false,
      isFavorite: json['is_favorite'] as bool? ?? false,
      discountLabel: json['discount_label'] as String?,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
    );
  }

  // WHY toJson: when you send data TO api
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'price': price,
      'weight': weight,
      'is_new': isNew,
      'is_favorite': isFavorite,
      'discount_label': discountLabel,
      'original_price': originalPrice,
    };
  }

  // WHY toString: makes debugging easy
  // print(product) shows readable info not "Instance of ProductModel"
  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price)';
  }

  // WHY == and hashCode: lets you compare products
  // products.contains(product) works correctly
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
