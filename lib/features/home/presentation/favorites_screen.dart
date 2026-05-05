import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/features/home/widgets/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 90.r,
                    height: 90.r,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: AppColors.primaryDark,
                      size: 42.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  AppText(
                    text: 'Favorites',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    text: 'Favorites screen',
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const HomeBottomNavigationBar(
          activeItem: HomeNavItem.favorites,
        ),
      ),
    );
  }
}
