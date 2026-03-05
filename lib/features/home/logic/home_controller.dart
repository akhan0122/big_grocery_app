import 'package:biggroceryapp/core/utils/theme/assets_class/asset_svg.dart';
import 'package:biggroceryapp/features/home/model/category_model.dart';
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
}
