import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/section_title.dart';
import 'package:biggroceryapp/core/global_widgets/text_form_field_widget.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_png.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/home/widgets/category_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
                                // Positioned(
                                //   bottom: 12.h,
                                //   left: 0,
                                //   right: 0,
                                //   child: Center(
                                //     child: DotsIndicator(
                                //       dotsCount: 4,
                                //       position: 1,
                                //       decorator: DotsDecorator(
                                //         activeColor: AppColors.primaryDark,
                                //         color: AppColors.primary,
                                //         size: Size.square(6.r),
                                //         activeSize: Size(16.w, 8.h),
                                //         activeShape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(
                                //             5.r,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final String weight;
  final bool isNew;
  final bool isFavorite;
  final bool isAddedToCart;
  final int quantity;

  final VoidCallback onAdd;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback? onFavoriteTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.weight,
    required this.isNew,
    required this.isFavorite,
    required this.isAddedToCart,
    required this.quantity,
    required this.onAdd,
    required this.onPlus,
    required this.onMinus,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 8.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isNew
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEFE4CB),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(6),
                                ),
                              ),
                              child: Text(
                                'NEW',
                                style: TextStyle(
                                  color: const Color(0xFFD39E2E),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : SizedBox(width: 44.w),
                      const Spacer(),
                      InkWell(
                        onTap: onFavoriteTap,
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.h, right: 2.w),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.red
                                : const Color(0xFF8D8D8D),
                            size: 22.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80.r,
                          height: 80.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE6EDC9),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18.r),
                            child: SvgPicture.asset(image, fit: BoxFit.contain),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          weight,
                          style: TextStyle(
                            color: const Color(0xFF8C8C8C),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isAddedToCart
              ? Container(
                  height: 42.h,
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFDCDCDC))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: onMinus,
                        child: Text(
                          '-',
                          style: TextStyle(
                            color: AppColors.primaryDark,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: onPlus,
                        child: Text(
                          '+',
                          style: TextStyle(
                            color: AppColors.primaryDark,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : InkWell(
                  onTap: onAdd,
                  child: Container(
                    height: 42.h,
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFFDCDCDC))),
                    ),
                    child: Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
