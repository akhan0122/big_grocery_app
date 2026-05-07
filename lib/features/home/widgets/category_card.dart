// lib/features/home/presentation/widgets/category_item_widget.dart

import 'package:biggroceryapp/features/home/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Icon circle ──────────────────────────────────
          Container(
            width: 54.r,
            height: 54.r,
            decoration: BoxDecoration(
              color: category.bgColor.withValues(
                alpha: isSelected ? 0.18 : 0.1,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? category.bgColor : Colors.transparent,
                width: 1.4,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: SvgPicture.asset(category.svgIcon),
            ),
          ),

          SizedBox(height: 6.h),

          // ── Label ────────────────────────────────────────
          Text(
            category.name,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? category.bgColor : const Color(0xFF868889),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
