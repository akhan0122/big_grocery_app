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
    final bool isCartActive = activeItem == HomeNavItem.cart;

    return SafeArea(
      top: false,
      child: SizedBox(
        height: 94.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 78.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
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
                        onTap: () => _go(context, AppRoutes.homeScreen),
                      ),
                    ),
                    Expanded(
                      child: _BottomNavIcon(
                        icon: Icons.person_outline,
                        activeIcon: Icons.person,
                        isActive: activeItem == HomeNavItem.profile,
                        onTap: () => _go(context, AppRoutes.profileScreen),
                      ),
                    ),
                    Expanded(
                      child: _BottomNavIcon(
                        icon: Icons.favorite_border,
                        activeIcon: Icons.favorite,
                        isActive: activeItem == HomeNavItem.favorites,
                        onTap: () => _go(context, AppRoutes.favoritesScreen),
                      ),
                    ),
                    Expanded(
                      child: _BottomNavIcon(
                        icon: Icons.favorite_border,
                        activeIcon: Icons.favorite,
                        isActive: activeItem == HomeNavItem.cart,
                        onTap: () => _go(context, AppRoutes.favoritesScreen),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _go(BuildContext context, String route) {
    context.go(route);
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
