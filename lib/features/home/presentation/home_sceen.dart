import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/section_title.dart';
import 'package:biggroceryapp/core/global_widgets/text_form_field_widget.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_png.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/home/widgets/category_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return SingleChildScrollView(
              // ← moved OUTSIDE padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Search (has padding) ────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: TextFormFieldWidget(
                      controller: TextEditingController(),
                      hintText: 'Search products...',
                      prefixIcon: Icons.search,
                    ),
                  ),

                  // ── Carousel (NO padding = full width) ──
                  SizedBox(
                    height: 260.h,
                    width: double.infinity, // ← full width
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              AssetPng.homescreen,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 70.h,
                          left: 45.w,
                          child: AppText(
                            text: "20% off on your\nfirst purchase",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Positioned(
                          bottom: 12.h,
                          left: 0,

                          child: DotsIndicator(
                            dotsCount: 4,
                            position: 1,
                            decorator: DotsDecorator(
                              activeColor: AppColors.primaryDark,
                              color: AppColors.primary,
                              size: Size.square(6.r),
                              activeSize: Size(16.w, 8.h),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ── Categories (has padding) ─────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SectionHeaderWidget(
                      title: 'Categories',
                      onSeeAllTap: () {},
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 14.w),
                          child: CategoryItemWidget(
                            category: controller.categories[index],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ── Featured Products (has padding) ───────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SectionHeaderWidget(
                      title: 'Featured Products',
                      onSeeAllTap: () {},
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // ── Grid (has padding) ────────────────────
                  // WHY shrinkWrap+NeverScroll:
                  // GridView inside SingleChildScrollView
                  // needs to know its own height upfront
                  // shrinkWrap calculates it, NeverScroll
                  // lets parent SingleChildScrollView handle scrolling
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GridView.builder(
                      shrinkWrap: true, // ← no blank!
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(child: Text('Product $index')),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
