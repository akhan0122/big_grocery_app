import 'package:biggroceryapp/core/network/api_client.dart';
import 'package:biggroceryapp/core/network/api_endpoints.dart';
import 'package:biggroceryapp/features/home/model/api_product_model.dart';

class HomeRepository {
  HomeRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<List<ApiProductModel>> getProducts() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.products,
      queryParameters: {'limit': 5, 'select': 'title,price'},
    );

    final products = response.data?['products'];
    if (products is! List) return [];

    return products
        .whereType<Map<String, dynamic>>()
        .map(ApiProductModel.fromJson)
        .toList();
  }
}
