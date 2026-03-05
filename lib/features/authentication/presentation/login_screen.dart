import 'package:biggroceryapp/core/global_widgets/app_elevated_button.dart';
import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/custom_appbar_widget.dart';
import 'package:biggroceryapp/core/global_widgets/switch_widget.dart';
import 'package:biggroceryapp/core/global_widgets/text_form_field_widget.dart';
import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_png.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        backgroundColor: Colors.transparent,
        title: 'Login',
        showBackButton: true,
        backIconColor: Colors.white,
        titleColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ── Layer 1: Hero Image (full width) ────────────
            SizedBox(
              height: 470.h,
              width: double.infinity,
              child: Image.asset(AssetPng.loginCover, fit: BoxFit.cover),
            ),

            Container(
              margin: EdgeInsets.only(top: 430.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r), // ← rounded corners
                  topRight: Radius.circular(30.r), // matching Figma
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Welcome text ──────────────────────────
                  AppText(
                    text: 'Welcome back!',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  AppText(
                    text: 'Sign in to your account',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ── Email field ───────────────────────────
                  TextFormFieldWidget(
                    controller: TextEditingController(),
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 14.h),

                  // ── Password field ────────────────────────
                  TextFormFieldWidget(
                    controller: TextEditingController(),
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  SizedBox(height: 16.h),

                  // ── Remember me + Forgot password ─────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppToggleWidget(value: false, onChanged: (val) {}),

                          SizedBox(width: 6.w),
                          AppText(
                            text: 'Remember me',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      AppText(
                        text: 'Forgot password',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // ── Login button ──────────────────────────
                  AppElevatedButton(
                    title: "Sign In",
                    onPressed: () {
                      AppRouter.push(AppRoutes.homeScreen);
                    },
                    titleStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ── Sign up link ──────────────────────────
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        AppRouter.push(AppRoutes.signUpScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
