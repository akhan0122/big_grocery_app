// lib/features/home/data/models/category_model.dart

import 'package:biggroceryapp/core/utils/theme/assets_class/asset_svg.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String name;
  final String svgIcon; // ← svg path
  final Color bgColor; // ← each category has different bg color

  const CategoryModel({
    required this.id,
    required this.name,
    required this.svgIcon,
    required this.bgColor,
  });
}

// Dummy data
