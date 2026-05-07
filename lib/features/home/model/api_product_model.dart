class ProductModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  Category? category;
  List<String>? images;

  ProductModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = _asInt(json['id']);
    title = json['title']?.toString();
    slug = json['slug']?.toString();
    price = _asInt(json['price']);
    description = json['description']?.toString();
    category = json['category'] is Map
        ? Category.fromJson((json['category'] as Map).cast<String, dynamic>())
        : null;
    images = _asStringList(json['images']);
  }

  String get imageUrl {
    final productImages = images;
    if (productImages == null) return '';
    for (final image in productImages) {
      if (image.isNotEmpty) return image;
    }
    return '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['price'] = price;
    data['description'] = description;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['images'] = images;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? slug;

  Category({this.id, this.name, this.image, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    id = _asInt(json['id']);
    name = json['name']?.toString();
    image = json['image']?.toString();
    slug = json['slug']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['slug'] = slug;
    return data;
  }
}

int? _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

List<String> _asStringList(Object? value) {
  if (value is List) {
    return value
        .map((item) => _cleanImageUrl(item.toString()))
        .where((item) => item.isNotEmpty)
        .toList();
  }
  if (value is String && value.isNotEmpty) {
    final image = _cleanImageUrl(value);
    return image.isEmpty ? [] : [image];
  }
  return [];
}

String _cleanImageUrl(String value) {
  var image = value.trim();
  image = image.replaceAll('\\', '');
  image = image.replaceAll('[', '');
  image = image.replaceAll(']', '');
  image = image.replaceAll('"', '');
  image = image.replaceAll("'", '');
  image = image.trim();

  if (!image.startsWith('http://') && !image.startsWith('https://')) {
    return '';
  }

  final uri = Uri.tryParse(image);
  if (uri == null || !uri.hasAuthority) return '';

  if (uri.host == 'placehold.co' &&
      !uri.path.endsWith('.png') &&
      !uri.path.endsWith('.jpg') &&
      !uri.path.endsWith('.jpeg') &&
      !uri.path.endsWith('.webp')) {
    return uri.replace(path: '${uri.path}.png').toString();
  }

  return image;
}
