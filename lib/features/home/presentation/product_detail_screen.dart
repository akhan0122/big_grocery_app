import 'package:biggroceryapp/core/global_widgets/app_elevated_button.dart';
import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/custom_appbar_widget.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_png.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: const AppBarWidget(
        showBackButton: true,
        backgroundColor: AppColors.primaryLight,
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipPath(
                clipper: BottomSemiCircleClipper(),
                child: Container(
                  width: double.infinity,
                  height: 240.h,
                  color: AppColors.primaryLight,
                ),
              ),
              Positioned(
                bottom: -58.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    AssetPng.lime,
                    height: 280.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 72.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: '\$2.22',
                                color: const Color(0xFF34C759),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 4.h),
                              AppText(
                                text: 'Organic Lemons',
                                color: Colors.black,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 4.h),
                              AppText(
                                text: '1.50 lbs',
                                color: const Color(0xFF8E8E93),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: const Color(0xFF8E8E93),
                          size: 24.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        AppText(
                          text: '4.5',
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(width: 6.w),
                        ...List.generate(
                          5,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: Icon(
                              index < 4 ? Icons.star : Icons.star_border,
                              color: const Color(0xFFF5B301),
                              size: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        AppText(
                          text: '(89 reviews)',
                          color: const Color(0xFF8E8E93),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: const Color(0xFF8E8E93),
                              fontSize: 15.sp,
                              height: 1.7,
                              fontWeight: FontWeight.w400,
                            ),
                            children: const [
                              TextSpan(
                                text:
                                    'Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. Organic lemons are considered to be the world\'s finest lemon for juicing. Organic lemons are loved for their fresh flavor and healthy benefits. You can use them in juices, salads, desserts, and many daily recipes. Their strong aroma and natural taste make them a favorite in many homes. ',
                              ),
                              TextSpan(
                                text: 'more',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      height: 54.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: AppText(
                                text: 'Quantity',
                                color: const Color(0xFF8E8E93),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: const Color(0xFFE5E5EA),
                          ),
                          Expanded(
                            child: Center(
                              child: AppText(
                                text: '-',
                                color: const Color(0xFF7AC943),
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: const Color(0xFFE5E5EA),
                          ),
                          Expanded(
                            child: Center(
                              child: AppText(
                                text: '3',
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: const Color(0xFFE5E5EA),
                          ),
                          Expanded(
                            child: Center(
                              child: AppText(
                                text: '+',
                                color: const Color(0xFF7AC943),
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    AppElevatedButton(
                      height: 58.h,
                      borderRadius: BorderRadius.circular(8.r),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFA8DB7A), Color(0xFF6FD12E)],
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: 'Add to cart',
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.76);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.76,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
