import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/section_title.dart';
import 'package:biggroceryapp/core/global_widgets/text_form_field_widget.dart';
import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_png.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/home/widgets/category_card.dart';
import 'package:biggroceryapp/features/home/widgets/home_bottom_navigation_bar.dart';
import 'package:biggroceryapp/features/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return Column(
                children: [
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 260.h,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  itemCount: 1,
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
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SectionHeaderWidget(
                              title: 'Featured Products',
                              onSeeAllTap: () {},
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12.w,
                                    mainAxisSpacing: 12.h,
                                    childAspectRatio: 0.74,
                                  ),
                              itemCount: controller.dummyProducts.length,
                              itemBuilder: (context, index) {
                                return GetBuilder<HomeController>(
                                  id: 'product_$index',
                                  builder: (controller) {
                                    final product =
                                        controller.dummyProducts[index];

                                    return ProductCard(
                                      name: product.name,
                                      image: product.imageUrl,
                                      price: product.price,
                                      weight: product.weight,
                                      isNew: product.isNew,
                                      isFavorite: product.isFavorite,
                                      isAddedToCart: product.isAddedToCart,
                                      quantity: product.quantity,
                                      onCardTap: () {
                                        AppRouter.push(
                                          AppRoutes.productDetailsById(
                                            product.id,
                                          ),
                                        );
                                      },
                                      onAdd: () {
                                        controller.addToCart(product);
                                      },
                                      onPlus: () {
                                        controller.increaseQty(product);
                                      },
                                      onMinus: () {
                                        controller.decreaseQty(product);
                                      },
                                      onFavoriteTap: () {
                                        controller.toggleFavorite(product);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: const HomeBottomNavigationBar(
          activeItem: HomeNavItem.home,
        ),
      ),
    );
  }
}
