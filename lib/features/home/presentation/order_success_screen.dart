import 'package:biggroceryapp/core/global_widgets/app_elevated_button.dart';
import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/custom_appbar_widget.dart';
import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: const AppBarWidget(
          title: 'Order Success',
          showBackButton: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(28.w, 26.h, 28.w, 18.h),
            child: Column(
              children: [
                const Spacer(flex: 3),
                Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.primaryDark,
                  size: 92.sp,
                ),
                SizedBox(height: 26.h),
                AppText(
                  text: 'Your order was\nsuccessful!',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                AppText(
                  text:
                      'You will get a response within\na few minutes.',
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 5),
                AppElevatedButton(
                  height: 58.h,
                  borderRadius: BorderRadius.circular(4.r),
                  title: 'Track order',
                  titleStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  onPressed: () => AppRouter.go(AppRoutes.homeScreen),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
