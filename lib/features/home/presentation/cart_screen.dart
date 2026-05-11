import 'package:biggroceryapp/core/global_widgets/app_elevated_button.dart';
import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/custom_appbar_widget.dart';
import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/home/model/api_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const double _shippingCharge = 1.60;

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
          title: 'Shopping Cart',
          showBackButton: true,
          backgroundColor: Colors.white,
        ),
        body: GetBuilder<HomeController>(
          id: 'cart',
          init: Get.isRegistered<HomeController>()
              ? Get.find<HomeController>()
              : HomeController(),
          builder: (controller) {
            final products = controller.cartProducts;
            if (products.isEmpty) {
              return const _EmptyCart();
            }

            final subtotal = controller.cartTotal;
            final total = subtotal + _shippingCharge;

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
                    itemCount: products.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _CartItemTile(
                        product: product,
                        quantity: controller.quantityFor(product),
                        onIncrease: () => controller.increaseQty(product),
                        onDecrease: () => controller.decreaseQty(product),
                        onRemove: () => controller.removeFromCart(product),
                      );
                    },
                  ),
                ),
                _CartSummary(
                  subtotal: subtotal,
                  shipping: _shippingCharge,
                  total: total,
                  onCheckout: () => AppRouter.push(AppRoutes.paymentMethod),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    required this.product,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final ProductModel product;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(product.id ?? product.title ?? product.hashCode),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24.w),
        color: const Color(0xFFF94F4F),
        child: Icon(Icons.delete_outline, color: Colors.white, size: 30.sp),
      ),
      onDismissed: (_) => onRemove(),
      child: Container(
        height: 100.h,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 16.w),
            _CartProductImage(image: product.imageUrl),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${(product.price ?? 0).toStringAsFixed(2)} x $quantity',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.title ?? 'Product',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.category?.name ?? 'Grocery',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            SizedBox(
              width: 38.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _QuantityIconButton(icon: Icons.add, onTap: onIncrease),
                  SizedBox(height: 9.h),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 9.h),
                  _QuantityIconButton(icon: Icons.remove, onTap: onDecrease),
                ],
              ),
            ),
            SizedBox(width: 12.w),
          ],
        ),
      ),
    );
  }
}

class _CartProductImage extends StatelessWidget {
  const _CartProductImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62.r,
      height: 62.r,
      decoration: const BoxDecoration(
        color: AppColors.primaryLight,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: image.isEmpty
          ? Icon(
              Icons.shopping_basket_outlined,
              color: AppColors.primaryDark,
              size: 30.sp,
            )
          : Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.shopping_basket_outlined,
                color: AppColors.primaryDark,
                size: 30.sp,
              ),
            ),
    );
  }
}

class _QuantityIconButton extends StatelessWidget {
  const _QuantityIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        width: 28.r,
        height: 22.r,
        child: Icon(icon, color: AppColors.primaryDark, size: 20.sp),
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.onCheckout,
  });

  final double subtotal;
  final double shipping;
  final double total;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 20.h),
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryLine(label: 'Subtotal', value: subtotal),
            SizedBox(height: 10.h),
            _SummaryLine(label: 'Shipping charges', value: shipping),
            SizedBox(height: 20.h),
            Divider(height: 1.h, color: const Color(0xFFE8E8E8)),
            SizedBox(height: 18.h),
            Row(
              children: [
                AppText(
                  text: 'Total',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
                const Spacer(),
                AppText(
                  text: '\$${total.toStringAsFixed(2)}',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ],
            ),
            SizedBox(height: 18.h),
            AppElevatedButton(
              height: 58.h,
              borderRadius: BorderRadius.circular(4.r),
              title: 'Checkout',
              titleStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
              onPressed: onCheckout,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84.r,
              height: 84.r,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primaryDark,
                size: 40.sp,
              ),
            ),
            SizedBox(height: 16.h),
            AppText(
              text: 'Shopping Cart',
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.h),
            AppText(
              text: 'Add products to see them here.',
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
