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
  Future<void>? _initialLoadFuture;

  bool isLoadingProducts = false;
  bool isLoadingCategories = false;
  String? productsError;
  String? categoriesError;
  String searchQuery = '';
  int selectedCategoryId = allCategoryId;
  List<ProductModel> apiProducts = [];
  final Set<int> favoriteProductIds = {};
  final Map<int, int> cartQuantities = {};
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

  List<ProductModel> get favoriteProducts {
    return apiProducts.where((product) {
      final id = product.id;
      return id != null && favoriteProductIds.contains(id);
    }).toList();
  }

  List<ProductModel> get cartProducts {
    return apiProducts.where((product) {
      final id = product.id;
      return id != null && cartQuantities.containsKey(id);
    }).toList();
  }

  double get cartTotal {
    return cartProducts.fold(0, (total, product) {
      final id = product.id;
      final quantity = id == null ? 0 : cartQuantities[id] ?? 0;
      return total + ((product.price ?? 0) * quantity);
    });
  }

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
    loadInitialData();
  }

  Future<void> loadInitialData({bool force = false}) {
    if (!force &&
        apiProducts.isNotEmpty &&
        categories.isNotEmpty &&
        productsError == null &&
        categoriesError == null) {
      return Future.value();
    }

    final currentLoad = _initialLoadFuture;
    if (!force && currentLoad != null) return currentLoad;

    _initialLoadFuture =
        Future.wait([
          getCategoriesFromApi(),
          getProductsFromApi(),
        ]).whenComplete(() {
          _initialLoadFuture = null;
        });

    return _initialLoadFuture!;
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

  bool isFavorite(ProductModel product) {
    final id = product.id;
    return id != null && favoriteProductIds.contains(id);
  }

  bool isAddedToCart(ProductModel product) {
    final id = product.id;
    return id != null && cartQuantities.containsKey(id);
  }

  int quantityFor(ProductModel product) {
    final id = product.id;
    if (id == null) return 0;
    return cartQuantities[id] ?? 0;
  }

  void toggleFavorite(ProductModel product) {
    final id = product.id;
    if (id == null) return;

    if (favoriteProductIds.contains(id)) {
      favoriteProductIds.remove(id);
    } else {
      favoriteProductIds.add(id);
    }

    _updateProductState(product);
  }

  void addToCart(ProductModel product) {
    final id = product.id;
    if (id == null) return;

    cartQuantities[id] = cartQuantities[id] ?? 1;
    _updateProductState(product);
  }

  void increaseQty(ProductModel product) {
    final id = product.id;
    if (id == null) return;

    cartQuantities[id] = (cartQuantities[id] ?? 0) + 1;
    _updateProductState(product);
  }

  void decreaseQty(ProductModel product) {
    final id = product.id;
    if (id == null) return;

    final currentQty = cartQuantities[id] ?? 0;
    if (currentQty <= 1) {
      cartQuantities.remove(id);
    } else {
      cartQuantities[id] = currentQty - 1;
    }

    _updateProductState(product);
  }

  void removeFromCart(ProductModel product) {
    final id = product.id;
    if (id == null) return;

    cartQuantities.remove(id);
    _updateProductState(product);
  }

  void _updateProductState(ProductModel product) {
    final id = product.id;
    update([
      'api_products',
      'favorites',
      'cart',
      if (id != null) 'product_detail_$id',
    ]);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
