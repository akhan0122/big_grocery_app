// lib/core/global_widgets/section_header_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.onSeeAllTap,
    this.seeAllText = 'See all',
    this.showSeeAll = true,
  });

  final String title;
  final VoidCallback? onSeeAllTap;
  final String seeAllText;
  final bool showSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ── Title ─────────────────────────────────────────
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),

        // ── See all ───────────────────────────────────────
        if (showSeeAll)
          GestureDetector(
            onTap: onSeeAllTap,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 22.r,
              color: AppColors.textSecondary,
            ),
          ),
      ],
    );
  }
}
