import 'package:biggroceryapp/core/network/api_exception.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_svg.dart';
import 'package:biggroceryapp/features/home/data/home_repository.dart';
import 'package:biggroceryapp/features/home/model/api_product_model.dart';
import 'package:biggroceryapp/features/home/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  bool isLoadingProducts = false;
  String? productsError;
  String searchQuery = '';
  List<ProductModel> apiProducts = [];
  final TextEditingController searchController = TextEditingController();

  List<ProductModel> get filteredProducts {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return apiProducts;

    return apiProducts.where((product) {
      final title = product.title?.toLowerCase() ?? '';
      final category = product.category?.name?.toLowerCase() ?? '';
      final description = product.description?.toLowerCase() ?? '';
      return title.contains(query) ||
          category.contains(query) ||
          description.contains(query);
    }).toList();
  }

  List<CategoryModel> categories = [
    CategoryModel(
      id: 1,
      name: 'Vegetables',
      svgIcon: AssetSvg.vegetables,
      bgColor: const Color(0xFF28B446), // light green
    ),
    CategoryModel(
      id: 2,
      name: 'Fruits',
      svgIcon: AssetSvg.fruits,
      bgColor: const Color(0xFFF8644A), // light red
    ),
    CategoryModel(
      id: 3,
      name: 'Beverages',
      svgIcon: AssetSvg.beverages,
      bgColor: const Color(0xFFF5BA3C), // light yellow
    ),
    CategoryModel(
      id: 4,
      name: 'Grocery',
      svgIcon: AssetSvg.grocery,
      bgColor: const Color(0xFFAE80FF), // light purple
    ),
    CategoryModel(
      id: 5,
      name: 'Edible Oil',
      svgIcon: AssetSvg.edibleOil,
      bgColor: const Color(0xFF0CD4DC), // light pink
    ),
    CategoryModel(
      id: 6,
      name: 'Household',
      svgIcon: AssetSvg.household,
      bgColor: const Color(0xFFFF7EB6), // light pink
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    getProductsFromApi();
  }

  Future<void> getProductsFromApi() async {
    isLoadingProducts = true;
    productsError = null;
    update(['api_products']);

    try {
      apiProducts = await _homeRepository.getProducts();
    } on ApiException catch (error) {
      productsError = error.message;
    } catch (_) {
      productsError = 'Unable to fetch products.';
    } finally {
      isLoadingProducts = false;
      update(['api_products']);
    }
  }

  void updateSearchQuery(String value) {
    searchQuery = value;
    update(['api_products']);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // void _updateProduct(ProductModel product, ProductModel updatedProduct) {
  //   final index = dummyProducts.indexWhere((item) => item.id == product.id);
  //   if (index == -1) return;
  //   dummyProducts[index] = updatedProduct;
  //   update(['product_$index', 'product_detail_${product.id}']);
  // }

  // void toggleFavorite(ProductModel product) {
  //   _updateProduct(product, product.copyWith(isFavorite: !product.isFavorite));
  // }

  // void addToCart(ProductModel product) {
  //   _updateProduct(
  //     product,
  //     product.copyWith(quantity: product.quantity + 1, isAddedToCart: true),
  //   );
  // }

  // void increaseQty(ProductModel product) {
  //   _updateProduct(product, product.copyWith(quantity: product.quantity + 1));
  // }

  // void decreaseQty(ProductModel product) {
  //   if (product.quantity == 0) return;
  //   final newQty = product.quantity - 1;
  //   _updateProduct(
  //     product,
  //     product.copyWith(quantity: newQty, isAddedToCart: newQty > 0),
  //   );
  // }
}
