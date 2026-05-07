import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

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
  final VoidCallback? onCardTap;
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
    this.onCardTap,
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
            child: InkWell(
              onTap: onCardTap,
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
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
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
                              child: SvgPicture.asset(
                                image,
                                fit: BoxFit.contain,
                              ),
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
