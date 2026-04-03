import 'package:biggroceryapp/core/utils/theme/assets_class/asset_svg.dart';
import 'package:biggroceryapp/features/home/model/category_model.dart';
import 'package:biggroceryapp/features/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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
  List<ProductModel> dummyProducts = [
    ProductModel(
      id: 1,
      name: 'Avocado',
      imageUrl: AssetSvg.fruits,
      price: 7.00,
      weight: '2.0 lbs',
      isNew: true,
      isAddedToCart: false,
    ),
    ProductModel(
      id: 2,
      name: 'Apple',
      imageUrl: AssetSvg.fruits,
      price: 5.50,
      weight: '1.5 lbs',
      isNew: false,
      isAddedToCart: false,
    ),
    ProductModel(
      id: 3,
      name: 'Banana',
      imageUrl: AssetSvg.fruits,
      price: 3.20,
      weight: '1.0 lbs',
      isNew: true,
      isAddedToCart: false,
    ),
    ProductModel(
      id: 4,
      name: 'Orange',
      imageUrl: AssetSvg.fruits,
      price: 4.75,
      weight: '2.2 lbs',
      isAddedToCart: false,
    ),
    ProductModel(
      id: 5,
      name: 'Strawberry',
      imageUrl: AssetSvg.fruits,
      price: 6.80,
      weight: '1.2 lbs',
      isNew: true,
      isAddedToCart: false,
    ),
    ProductModel(
      id: 6,
      name: 'Mango',
      imageUrl: AssetSvg.fruits,
      price: 8.40,
      weight: '2.5 lbs',
      isAddedToCart: false,
    ),
    ProductModel(
      id: 7,
      name: 'Pineapple',
      imageUrl: AssetSvg.fruits,
      price: 9.99,
      weight: '3.0 lbs',
      isAddedToCart: false,
    ),
    ProductModel(
      id: 8,
      name: 'Watermelon',
      imageUrl: AssetSvg.fruits,
      price: 12.50,
      weight: '5.0 lbs',
      isAddedToCart: false,
    ),
  ];

  void toggleFavorite(ProductModel product) {
    final index = dummyProducts.indexWhere((item) => item.id == product.id);
    if (index == -1) return;

    dummyProducts[index] = dummyProducts[index].copyWith(
      isFavorite: !dummyProducts[index].isFavorite,
    );
    update(['product_$index']);
  }

  void addToCart(ProductModel product) {
    final index = dummyProducts.indexWhere((item) => item.id == product.id);
    if (index == -1) return;
    dummyProducts[index] = dummyProducts[index].copyWith(
      quantity: product.quantity + 1,
      isAddedToCart: true,
    );
    update(['product_$index']);
  }

  void increaseQty(ProductModel product) {
    final index = dummyProducts.indexWhere((item) => item.id == product.id);
    if (index == -1) return;
    dummyProducts[index] = dummyProducts[index].copyWith(
      quantity: product.quantity + 1,
    );
    update(['product_$index']);
  }

  void decreaseQty(ProductModel product) {
    if (product.quantity == 0) return; // safety guard
    final index = dummyProducts.indexWhere((item) => item.id == product.id);
    if (index == -1) return;
    final newQty = product.quantity - 1;
    dummyProducts[index] = dummyProducts[index].copyWith(
      quantity: newQty,
      isAddedToCart: newQty > 0, // false when hits 0, shows "Add to cart" again
    );
    update(['product_$index']);
  }
}
