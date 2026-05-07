import 'package:biggroceryapp/core/network/api_client.dart';
import 'package:biggroceryapp/core/network/api_endpoints.dart';
import 'package:biggroceryapp/features/home/model/api_product_model.dart';
import 'package:biggroceryapp/features/home/model/category_model.dart';
import 'package:flutter/material.dart';

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
        .map(
          (product) => ProductModel.fromJson(product.cast<String, dynamic>()),
        )
        .toList();
  }

  Future<List<CategoryModel>> getCategories({
    required List<String> icons,
    required List<Color> colors,
  }) async {
    final response = await _apiClient.get<Object?>(ApiEndpoints.categories);

    final data = response.data;
    if (data is! List) return [];

    return data.whereType<Map>().toList().asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value.cast<String, dynamic>();
      return CategoryModel.fromJson(
        category,
        svgIcon: icons[index % icons.length],
        bgColor: colors[index % colors.length],
      );
    }).toList();
  }
}
