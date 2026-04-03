class ProductModel {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String weight;

  // UI states
  final bool isNew;
  final bool isFavorite;

  // CART states (IMPORTANT)
  final bool isAddedToCart;
  final int quantity;

  // Future use
  final String? discountLabel;
  final double? originalPrice;

  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.weight,
    this.isNew = false,
    this.isFavorite = false,
    this.isAddedToCart = false,
    this.quantity = 0,
    this.discountLabel,
    this.originalPrice,
  });

  // 🔥 Important fix for nullable handling
  static const _unset = Object();

  ProductModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    double? price,
    String? weight,
    bool? isNew,
    bool? isFavorite,
    bool? isAddedToCart,
    int? quantity,
    Object? discountLabel = _unset,
    Object? originalPrice = _unset,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      isNew: isNew ?? this.isNew,
      isFavorite: isFavorite ?? this.isFavorite,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
      quantity: quantity ?? this.quantity,
      discountLabel: discountLabel == _unset
          ? this.discountLabel
          : discountLabel as String?,
      originalPrice: originalPrice == _unset
          ? this.originalPrice
          : originalPrice as double?,
    );
  }

  // ✅ Safe JSON parsing
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      price: (json['price'] as num).toDouble(),
      weight: json['weight'] as String,
      isNew: json['is_new'] as bool? ?? false,
      isFavorite: json['is_favorite'] as bool? ?? false,
      isAddedToCart: json['is_added_to_cart'] as bool? ?? false,
      quantity: json['quantity'] as int? ?? 0,
      discountLabel: json['discount_label'] as String?,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'price': price,
      'weight': weight,
      'is_new': isNew,
      'is_favorite': isFavorite,
      'is_added_to_cart': isAddedToCart,
      'quantity': quantity,
      'discount_label': discountLabel,
      'original_price': originalPrice,
    };
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, qty: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
