import 'package:biggroceryapp/core/network/api_client.dart';
import 'package:biggroceryapp/core/network/api_endpoints.dart';
import 'package:biggroceryapp/features/home/model/api_product_model.dart';

class HomeRepository {
  HomeRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<List<ProductModel>> getProducts() async {
    final response = await _apiClient.get<Object?>(ApiEndpoints.products);

    final data = response.data;
    final products = data is List
        ? data
        : data is Map<String, dynamic>
        ? data['products']
        : null;
    if (products is! List) return [];

    return products
        .whereType<Map>()
        .map((product) => ProductModel.fromJson(product.cast<String, dynamic>()))
        .toList();
  }
}
