import 'package:biggroceryapp/core/network/api_exception.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_svg.dart';
import 'package:biggroceryapp/features/home/data/home_repository.dart';
import 'package:biggroceryapp/features/home/model/api_product_model.dart';
import 'package:biggroceryapp/features/home/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  static const int allCategoryId = 0;

  bool isLoadingProducts = false;
  bool isLoadingCategories = false;
  String? productsError;
  String? categoriesError;
  String searchQuery = '';
  int selectedCategoryId = allCategoryId;
  List<ProductModel> apiProducts = [];
  final TextEditingController searchController = TextEditingController();

  List<ProductModel> get filteredProducts {
    Iterable<ProductModel> products = apiProducts;

    if (selectedCategoryId != allCategoryId) {
      products = products.where(
        (product) => product.category?.id == selectedCategoryId,
      );
    }

    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return products.toList();

    return products.where((product) {
      final title = product.title?.toLowerCase() ?? '';
      final category = product.category?.name?.toLowerCase() ?? '';
      final description = product.description?.toLowerCase() ?? '';
      return title.contains(query) ||
          category.contains(query) ||
          description.contains(query);
    }).toList();
  }

  final List<String> _categoryIcons = const [
    AssetSvg.grocery,
    AssetSvg.vegetables,
    AssetSvg.fruits,
    AssetSvg.beverages,
    AssetSvg.edibleOil,
    AssetSvg.household,
  ];

  final List<Color> _categoryColors = const [
    Color(0xFFAE80FF),
    Color(0xFF28B446),
    Color(0xFFF8644A),
    Color(0xFFF5BA3C),
    Color(0xFF0CD4DC),
    Color(0xFFFF7EB6),
  ];

  final CategoryModel allCategory = const CategoryModel(
    id: allCategoryId,
    name: 'All',
    svgIcon: AssetSvg.grocery,
    bgColor: Color(0xFFAE80FF),
  );

  List<CategoryModel> categories = [];

  List<CategoryModel> get categoriesWithAll => [allCategory, ...categories];

  List<CategoryModel> fallbackCategories = [
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
    getCategoriesFromApi();
    getProductsFromApi();
  }

  Future<void> getCategoriesFromApi() async {
    isLoadingCategories = true;
    categoriesError = null;
    update(['categories']);

    try {
      categories = await _homeRepository.getCategories(
        icons: _categoryIcons,
        colors: _categoryColors,
      );
      if (categories.isEmpty) {
        categories = fallbackCategories;
      }
    } on ApiException catch (error) {
      categoriesError = error.message;
      categories = fallbackCategories;
    } catch (_) {
      categoriesError = 'Unable to fetch categories.';
      categories = fallbackCategories;
    } finally {
      isLoadingCategories = false;
      update(['categories', 'api_products']);
    }
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

  void selectCategory(CategoryModel category) {
    selectedCategoryId = category.id;
    update(['categories', 'api_products']);
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
