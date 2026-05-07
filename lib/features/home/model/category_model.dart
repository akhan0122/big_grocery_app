import 'package:flutter/material.dart';

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.svgIcon,
    required this.bgColor,
  });

  final int id;
  final String name;
  final String svgIcon;
  final Color bgColor;

  factory CategoryModel.fromJson(
    Map<String, dynamic> json, {
    required String svgIcon,
    required Color bgColor,
  }) {
    return CategoryModel(
      id: _asInt(json['id']) ?? 0,
      name: json['name']?.toString() ?? 'Category',
      svgIcon: svgIcon,
      bgColor: bgColor,
    );
  }
}

int? _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}
