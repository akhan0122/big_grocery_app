import 'package:biggroceryapp/core/global_widgets/app_elevated_button.dart';
import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/custom_appbar_widget.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/features/home/model/api_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel? product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isFavorite = false;
  int _quantity = 1;

  ProductModel? get product => widget.product;

  @override
  Widget build(BuildContext context) {
    final product = this.product;
    if (product == null) {
      return Scaffold(
        appBar: const AppBarWidget(showBackButton: true),
        body: Center(
          child: AppText(
            text: 'Product not found',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: const AppBarWidget(
        showBackButton: true,
        backgroundColor: AppColors.primaryLight,
      ),
      body: Column(
        children: [
          _ProductHero(image: product.imageUrl),
          SizedBox(height: 58.h),
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
                padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 18.h),
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
                              Row(
                                children: [
                                  AppText(
                                    text:
                                        '\$${(product.price ?? 0).toStringAsFixed(2)}',
                                    color: const Color(0xFF34C759),
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  SizedBox(width: 10.w),
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryLight,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: AppText(
                                        text:
                                            product.category?.name ?? 'Grocery',
                                        color: AppColors.primaryDark,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              AppText(
                                text: product.title ?? 'Product',
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                          borderRadius: BorderRadius.circular(20.r),
                          child: Padding(
                            padding: EdgeInsets.all(4.r),
                            child: Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorite
                                  ? Colors.red
                                  : const Color(0xFF8E8E93),
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    const _RatingRow(),
                    SizedBox(height: 16.h),
                    AppText(
                      text: 'Description',
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text(
                          _descriptionFor(product),
                          style: TextStyle(
                            color: const Color(0xFF8E8E93),
                            fontSize: 15.sp,
                            height: 1.7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _QuantitySelector(
                      quantity: _quantity,
                      onDecrease: () {
                        if (_quantity == 1) return;
                        setState(() {
                          _quantity--;
                        });
                      },
                      onIncrease: () {
                        setState(() {
                          _quantity++;
                        });
                      },
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

  String _descriptionFor(ProductModel product) {
    final description = product.description?.trim();
    if (description != null && description.isNotEmpty) return description;
    return 'Fresh grocery product selected for everyday shopping.';
  }
}

class _ProductHero extends StatelessWidget {
  const _ProductHero({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: BottomSemiCircleClipper(),
          child: Container(
            width: double.infinity,
            height: 230.h,
            color: AppColors.primaryLight,
          ),
        ),
        Positioned(
          bottom: -56.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: 210.r,
              width: 210.r,
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDark.withValues(alpha: 0.18),
                    blurRadius: 28.r,
                    offset: Offset(0, 14.h),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: _DetailProductImage(image: image),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow();

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _DetailProductImage extends StatelessWidget {
  const _DetailProductImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return const Icon(
        Icons.shopping_basket_outlined,
        color: AppColors.primaryDark,
        size: 96,
      );
    }

    return Image.network(
      image,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryDark,
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return const Icon(
          Icons.shopping_basket_outlined,
          color: AppColors.primaryDark,
          size: 96,
        );
      },
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFEDEDED)),
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
          const _VerticalDivider(),
          Expanded(
            child: _QuantityButton(icon: '-', onTap: onDecrease),
          ),
          const _VerticalDivider(),
          Expanded(
            child: Center(
              child: AppText(
                text: '$quantity',
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const _VerticalDivider(),
          Expanded(
            child: _QuantityButton(icon: '+', onTap: onIncrease),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.infinity,
      color: const Color(0xFFE5E5EA),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Center(
        child: Container(
          width: 28.w,
          height: 28.h,
          decoration: const BoxDecoration(
            color: Color(0xFFE7F4D8),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AppText(
              text: icon,
              color: const Color(0xFF7AC943),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
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
