// // lib/core/global_widgets/app_bar_widget.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:biggroceryapp/core/utils/app_colors.dart';
// lib/core/global_widgets/app_bar_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = false,
    this.showCartIcon = false,
    this.showNotificationIcon = false,
    this.showFilterIcon = false,
    this.cartItemCount = 0,
    this.notificationCount = 0,
    this.onCartTap,
    this.onNotificationTap,
    this.onFilterTap,
    this.onBackTap,
    // ── All colors optional with smart defaults ──────────────
    this.backgroundColor,       // null = uses theme default
    this.titleColor,            // null = AppColors.textPrimary
    this.iconColor,             // null = AppColors.textPrimary
    this.badgeColor,            // null = AppColors.primary
    this.badgeTextColor,        // null = Colors.white
    this.backIconColor,         // null = falls back to iconColor
    // ─────────────────────────────────────────────────────────
    this.centerTitle = true,
    this.elevation = 0,
  });

  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final bool showCartIcon;
  final bool showNotificationIcon;
  final bool showFilterIcon;
  final int cartItemCount;
  final int notificationCount;
  final VoidCallback? onCartTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onBackTap;

  // ── Color parameters — ALL optional ─────────────────────────
  // WHY nullable instead of required:
  // caller only passes what they need to change
  // everything else falls back to your app's design system
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final Color? backIconColor;    // WHY separate: sometimes back arrow
                                 // needs different color (transparent appbars)
  final bool centerTitle;
  final double elevation;

  // ── Internal color resolvers ─────────────────────────────────
  // WHY: centralize fallback logic — don't repeat ?? everywhere in build()
  Color get _iconColor        => iconColor ?? AppColors.textPrimary;
  Color get _titleColor       => titleColor ?? AppColors.textPrimary;
  Color get _badgeColor       => badgeColor ?? AppColors.primary;
  Color get _badgeTextColor   => badgeTextColor ?? Colors.white;
  Color get _backIconColor    => backIconColor ?? _iconColor;
  // backgroundColor stays nullable — null lets AppBar use theme color

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,  // null = theme default ✅
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,

      // ── Leading ───────────────────────────────────────────
      leading: showBackButton
          ? IconButton(
              onPressed: onBackTap ?? () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: _backIconColor,    // ← uses resolver
                size: 25.r,
              ),
            )
          : null,

      // ── Title ─────────────────────────────────────────────
      title: titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: _titleColor,   // ← uses resolver
                  ),
                )
              : null),

      // ── Actions ───────────────────────────────────────────
      actions: [
        if (showNotificationIcon)
          _BadgeIconButton(
            icon: Icons.notifications_outlined,
            count: notificationCount,
            onTap: onNotificationTap,
            iconColor: _iconColor,        // ← passed down
            badgeColor: _badgeColor,
            badgeTextColor: _badgeTextColor,
          ),
        if (showCartIcon)
          _BadgeIconButton(
            icon: Icons.shopping_cart_outlined,
            count: cartItemCount,
            onTap: onCartTap,
            iconColor: _iconColor,
            badgeColor: _badgeColor,
            badgeTextColor: _badgeTextColor,
          ),
        if (showFilterIcon)
          IconButton(
            onPressed: onFilterTap,
            icon: Icon(
              Icons.tune,
              color: _iconColor,          // ← uses resolver
              size: 22.r,
            ),
          ),
        SizedBox(width: 4.w),
      ],
    );
  }
}

// ── Badge Icon Button ──────────────────────────────────────────
class _BadgeIconButton extends StatelessWidget {
  const _BadgeIconButton({
    required this.icon,
    required this.count,
    this.onTap,
    this.iconColor,         // ← optional, from parent
    this.badgeColor,
    this.badgeTextColor,
  });

  final IconData icon;
  final int count;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? badgeColor;
  final Color? badgeTextColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: iconColor ?? AppColors.textPrimary,  // ← safe fallback
            size: 24.r,
          ),
        ),
        if (count > 0)
          Positioned(
            right: 6.w,
            top: 6.h,
            child: Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                color: badgeColor ?? AppColors.primary, // ← safe fallback
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: 16.r,
                minHeight: 16.r,
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: TextStyle(
                  color: badgeTextColor ?? Colors.white, // ← safe fallback
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
// class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
//   const AppBarWidget({
//     super.key,
//     this.title,
//     this.showBackButton = false,
//     this.showCartIcon = false,
//     this.showNotificationIcon = false,
//     this.showFilterIcon = false,
//     this.cartItemCount = 0,
//     this.notificationCount = 0,
//     this.onCartTap,
//     this.onNotificationTap,
//     this.onFilterTap,
//     this.onBackTap,
//     this.backgroundColor = Colors.white,
//     this.titleWidget, // ← for logo instead of text
//     this.centerTitle = true,
//     this.fontColor,
//   });

//   final String? title;
//   final Widget? titleWidget; // WHY: home shows logo, others show text
//   final bool showBackButton;
//   final bool showCartIcon;
//   final bool showNotificationIcon;
//   final bool showFilterIcon;
//   final int cartItemCount; // WHY: badge shows count on cart icon
//   final int notificationCount;
//   final VoidCallback? onCartTap;
//   final VoidCallback? onNotificationTap;
//   final VoidCallback? onFilterTap;
//   final VoidCallback? onBackTap;
//   final Color backgroundColor;
//   final bool centerTitle;
//   final Color? fontColor;

//   @override
//   // WHY: PreferredSizeWidget needs this — tells Scaffold how tall AppBar is
//   Size get preferredSize => Size.fromHeight(56.h);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: backgroundColor,
//       elevation: 0,
//       centerTitle: centerTitle,
//       automaticallyImplyLeading: false, // WHY: we control back button ourselves
//       // ── Leading (left side) ───────────────────────────────
//       leading: showBackButton
//           ? IconButton(
//               onPressed: onBackTap ?? () => Navigator.of(context).pop(),
//               icon: Icon(
//                 Icons.arrow_back_rounded,
//                 color: AppColors.textPrimary,
//                 size: 25.r,
//               ),
//             )
//           : null,

//       // ── Title (center) ────────────────────────────────────
//       // WHY: titleWidget takes priority — if provided use it
//       // otherwise fall back to text title
//       title:
//           titleWidget ??
//           (title != null
//               ? Text(
//                   title!,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w600,
//                     color: fontColor ?? AppColors.textPrimary,
//                   ),
//                 )
//               : null),

//       // ── Actions (right side) ─────────────────────────────
//       actions: [
//         if (showNotificationIcon)
//           _BadgeIconButton(
//             icon: Icons.notifications_outlined,
//             count: notificationCount,
//             onTap: onNotificationTap,
//           ),
//         if (showCartIcon)
//           _BadgeIconButton(
//             icon: Icons.shopping_cart_outlined,
//             count: cartItemCount,
//             onTap: onCartTap,
//           ),
//         if (showFilterIcon)
//           IconButton(
//             onPressed: onFilterTap,
//             icon: Icon(
//               Icons.tune, // ← the ≡ filter icon from your Figma
//               color: AppColors.textPrimary,
//               size: 22.r,
//             ),
//           ),
//         SizedBox(width: 4.w), // right padding
//       ],
//     );
//   }
// }

// // ── Badge Icon Button ──────────────────────────────────────────
// // WHY separate widget: badge logic is complex enough to isolate
// // Used for both cart and notification icons
// class _BadgeIconButton extends StatelessWidget {
//   const _BadgeIconButton({required this.icon, required this.count, this.onTap});

//   final IconData icon;
//   final int count;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         IconButton(
//           onPressed: onTap,
//           icon: Icon(icon, color: AppColors.textPrimary, size: 24.r),
//         ),

//         // badge — only shows when count > 0
//         if (count > 0)
//           Positioned(
//             right: 6.w,
//             top: 6.h,
//             child: Container(
//               padding: EdgeInsets.all(3.r),
//               decoration: const BoxDecoration(
//                 color: AppColors.primary, // your green color
//                 shape: BoxShape.circle,
//               ),
//               constraints: BoxConstraints(minWidth: 16.r, minHeight: 16.r),
//               child: Text(
//                 count > 99 ? '99+' : '$count', // WHY: cap at 99+
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 9.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
