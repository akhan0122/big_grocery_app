import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:biggroceryapp/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

enum HomeNavItem { home, profile, favorites, cart }

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key, required this.activeItem});

  final HomeNavItem activeItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 78.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18.r,
              offset: Offset(0, -4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _BottomNavIcon(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                isActive: activeItem == HomeNavItem.home,
                onTap: () => _go(context, HomeNavItem.home),
              ),
            ),
            Expanded(
              child: _BottomNavIcon(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                isActive: activeItem == HomeNavItem.profile,
                onTap: () => _go(context, HomeNavItem.profile),
              ),
            ),
            Expanded(
              child: _BottomNavIcon(
                icon: Icons.favorite_border,
                activeIcon: Icons.favorite,
                isActive: activeItem == HomeNavItem.favorites,
                onTap: () => _go(context, HomeNavItem.favorites),
              ),
            ),
            Expanded(
              child: _BottomNavIcon(
                icon: Icons.shopping_cart_outlined,
                activeIcon: Icons.shopping_cart,
                isActive: activeItem == HomeNavItem.cart,
                onTap: () => _go(context, HomeNavItem.cart),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _go(BuildContext context, HomeNavItem item) {
    if (item == activeItem) return;
    context.go(item.route);
  }
}

extension on HomeNavItem {
  String get route {
    switch (this) {
      case HomeNavItem.home:
        return AppRoutes.homeScreen;
      case HomeNavItem.profile:
        return AppRoutes.profileScreen;
      case HomeNavItem.favorites:
        return AppRoutes.favoritesScreen;
      case HomeNavItem.cart:
        return AppRoutes.cartScreen;
    }
  }
}

class _BottomNavIcon extends StatelessWidget {
  const _BottomNavIcon({
    required this.icon,
    required this.activeIcon,
    required this.onTap,
    required this.isActive,
  });

  final IconData icon;
  final IconData activeIcon;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Icon(
          isActive ? activeIcon : icon,
          color: isActive ? AppColors.primaryDark : AppColors.textSecondary,
          size: 32.sp,
        ),
      ),
    );
  }
}
