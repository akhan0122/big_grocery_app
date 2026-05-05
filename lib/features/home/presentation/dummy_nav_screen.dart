import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/features/home/widgets/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DummyNavScreen extends StatelessWidget {
  const DummyNavScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.activeItem,
  });

  final String title;
  final IconData icon;
  final HomeNavItem activeItem;

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
                  child: Icon(icon, color: AppColors.primaryDark, size: 42.sp),
                ),
                SizedBox(height: 18.h),
                AppText(
                  text: title,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 8.h),
                AppText(
                  text: 'Dummy screen',
                  color: AppColors.textSecondary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: HomeBottomNavigationBar(activeItem: activeItem),
      ),
    );
  }
}
