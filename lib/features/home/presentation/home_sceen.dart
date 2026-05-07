import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/section_title.dart';
import 'package:biggroceryapp/core/global_widgets/text_form_field_widget.dart';
import 'package:biggroceryapp/core/services/app_router.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:biggroceryapp/core/utils/theme/assets_class/asset_png.dart';
import 'package:biggroceryapp/features/home/logic/home_controller.dart';
import 'package:biggroceryapp/features/home/model/api_product_model.dart';
import 'package:biggroceryapp/features/home/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
          child: IndexedStack(
            index: _currentIndex,
            children: const [
              _HomeTabContent(),
              _FavoritesTabContent(),
              _CartTabContent(),
              _SimpleTabContent(title: 'Setting'),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.primaryDark,
          unselectedItemColor: AppColors.hintFont,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabContent extends StatelessWidget {
  const _HomeTabContent();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: TextFormFieldWidget(
                controller: controller.searchController,
                hintText: 'Search products...',
                prefixIcon: Icons.search,
                onChanged: controller.updateSearchQuery,
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
                        onSeeAllTap: () {
                          AppRouter.push(AppRoutes.categories);
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GetBuilder<HomeController>(
                      id: 'categories',
                      builder: (controller) {
                        final categories = controller.categoriesWithAll;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 94.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  return Padding(
                                    padding: EdgeInsets.only(right: 14.w),
                                    child: CategoryItemWidget(
                                      category: category,
                                      isSelected:
                                          controller.selectedCategoryId ==
                                          category.id,
                                      onTap: () {
                                        controller.selectCategory(category);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (controller.categoriesError != null)
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  16.w,
                                  0,
                                  16.w,
                                  8.h,
                                ),
                                child: Text(
                                  controller.categoriesError!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
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
                    GetBuilder<HomeController>(
                      id: 'api_products',
                      builder: (controller) {
                        if (controller.isLoadingProducts) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 28.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final error = controller.productsError;
                        if (error != null) {
                          return _ProductsMessage(
                            message: error,
                            actionText: 'Retry',
                            onActionTap: controller.getProductsFromApi,
                          );
                        }

                        final products = controller.filteredProducts;
                        if (products.isEmpty) {
                          return _ProductsMessage(
                            message:
                                controller.selectedCategoryId ==
                                    HomeController.allCategoryId
                                ? 'No products found.'
                                : 'No products found in this category.',
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                  childAspectRatio: 0.66,
                                ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];

                              return ProductCard(
                                name: product.title ?? '',
                                image: product.imageUrl,
                                price: product.price?.toDouble() ?? 0.0,
                                weight: product.category?.name ?? 'Grocery',
                                isNew: index % 2 == 0,
                                isFavorite: controller.isFavorite(product),
                                isAddedToCart: controller.isAddedToCart(
                                  product,
                                ),
                                quantity: controller.quantityFor(product),
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
                                onCardTap: () {
                                  AppRouter.push(
                                    AppRoutes.productDetailsById(
                                      product.id ?? 0,
                                    ),
                                    extra: product,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FavoritesTabContent extends StatelessWidget {
  const _FavoritesTabContent();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'favorites',
      builder: (controller) {
        final products = controller.favoriteProducts;
        if (products.isEmpty) {
          return const _EmptyTabMessage(
            icon: Icons.favorite_border,
            title: 'No favorites yet',
            subtitle: 'Tap the heart on products you like.',
          );
        }

        return _ProductListTab(
          title: 'Favorite',
          products: products,
          itemBuilder: (product) {
            return _FavoriteProductTile(product: product);
          },
        );
      },
    );
  }
}

class _CartTabContent extends StatelessWidget {
  const _CartTabContent();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'cart',
      builder: (controller) {
        final products = controller.cartProducts;
        if (products.isEmpty) {
          return const _EmptyTabMessage(
            icon: Icons.shopping_cart_outlined,
            title: 'Cart is empty',
            subtitle: 'Add products to see them here.',
          );
        }

        return Column(
          children: [
            Expanded(
              child: _ProductListTab(
                title: 'Cart',
                products: products,
                itemBuilder: (product) {
                  return _CartProductTile(product: product);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFECECEC))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '\$${controller.cartTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppRouter.push(AppRoutes.paymentMethod);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProductListTab extends StatelessWidget {
  const _ProductListTab({
    required this.title,
    required this.products,
    required this.itemBuilder,
  });

  final String title;
  final List<ProductModel> products;
  final Widget Function(ProductModel product) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      itemCount: products.length + 1,
      separatorBuilder: (_, index) {
        if (index == 0) return SizedBox(height: 12.h);
        return SizedBox(height: 10.h);
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return AppText(
            text: title,
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
          );
        }
        return itemBuilder(products[index - 1]);
      },
    );
  }
}

class _FavoriteProductTile extends StatelessWidget {
  const _FavoriteProductTile({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'favorites',
      builder: (controller) {
        return _ProductTileShell(
          product: product,
          trailing: IconButton(
            onPressed: () {
              controller.toggleFavorite(product);
            },
            icon: const Icon(Icons.favorite, color: Colors.red),
          ),
          bottom: Row(
            children: [
              Expanded(
                child: Text(
                  product.category?.name ?? 'Grocery',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  controller.addToCart(product);
                },
                child: Text(
                  controller.isAddedToCart(product)
                      ? 'Added (${controller.quantityFor(product)})'
                      : 'Add to Cart',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CartProductTile extends StatelessWidget {
  const _CartProductTile({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'cart',
      builder: (controller) {
        final quantity = controller.quantityFor(product);
        return _ProductTileShell(
          product: product,
          trailing: IconButton(
            onPressed: () {
              controller.removeFromCart(product);
            },
            icon: const Icon(Icons.delete_outline, color: Color(0xFF8E8E93)),
          ),
          bottom: Row(
            children: [
              Text(
                '\$${((product.price ?? 0) * quantity).toStringAsFixed(2)}',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              _SmallQtyButton(
                icon: '-',
                onTap: () {
                  controller.decreaseQty(product);
                },
              ),
              SizedBox(width: 10.w),
              Text(
                '$quantity',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 10.w),
              _SmallQtyButton(
                icon: '+',
                onTap: () {
                  controller.increaseQty(product);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProductTileShell extends StatelessWidget {
  const _ProductTileShell({
    required this.product,
    required this.trailing,
    required this.bottom,
  });

  final ProductModel product;
  final Widget trailing;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 78.r,
              height: 78.r,
              color: const Color(0xFFF5F8F1),
              child: _ProductImage(image: product.imageUrl),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ),
                    trailing,
                  ],
                ),
                Text(
                  '\$${(product.price ?? 0).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.h),
                bottom,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallQtyButton extends StatelessWidget {
  const _SmallQtyButton({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: 28.r,
        height: 28.r,
        decoration: const BoxDecoration(
          color: Color(0xFFE7F4D8),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            icon,
            style: TextStyle(
              color: AppColors.primaryDark,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyTabMessage extends StatelessWidget {
  const _EmptyTabMessage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primaryDark, size: 48.sp),
            SizedBox(height: 12.h),
            AppText(
              text: title,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.h),
            AppText(
              text: subtitle,
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

class _SimpleTabContent extends StatelessWidget {
  const _SimpleTabContent({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText(
        text: '$title Screen',
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ProductsMessage extends StatelessWidget {
  const _ProductsMessage({
    required this.message,
    this.actionText,
    this.onActionTap,
  });

  final String message;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
      child: Center(
        child: Column(
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF616161),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (actionText != null && onActionTap != null) ...[
              SizedBox(height: 12.h),
              TextButton(onPressed: onActionTap, child: Text(actionText!)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return Icon(
        Icons.shopping_basket_outlined,
        color: AppColors.primaryDark,
        size: 38.sp,
      );
    }

    return Image.network(
      image,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: SizedBox(
            width: 20.r,
            height: 20.r,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryDark,
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return Icon(
          Icons.shopping_basket_outlined,
          color: AppColors.primaryDark,
          size: 38.sp,
        );
      },
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
  final VoidCallback onCardTap;
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
    required this.onCardTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE9E9E9), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onCardTap,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 116.h,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F8F1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: _ProductImage(image: image),
                                ),
                              ),
                            ),
                            if (isNew)
                              Positioned(
                                top: 8.h,
                                left: 8.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF5D8),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: const Color(0xFFD39E2E),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 6.h,
                              right: 6.w,
                              child: Material(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: const CircleBorder(),
                                child: InkWell(
                                  onTap: onFavoriteTap,
                                  customBorder: const CircleBorder(),
                                  child: SizedBox(
                                    width: 30.r,
                                    height: 30.r,
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? Colors.red
                                          : const Color(0xFF8D8D8D),
                                      size: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 9.h),
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          height: 1.15,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        weight,
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
              ),
            ),
          ),
          isAddedToCart
              ? Container(
                  height: 44.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FBF4),
                    border: Border(top: BorderSide(color: Color(0xFFE5EEDC))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: onMinus,
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          width: 28.r,
                          height: 28.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE7F4D8),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        onTap: onPlus,
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          width: 28.r,
                          height: 28.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE7F4D8),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : InkWell(
                  onTap: onAdd,
                  child: Container(
                    height: 44.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8FBF4),
                      border: Border(top: BorderSide(color: Color(0xFFE5EEDC))),
                    ),
                    child: Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
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
