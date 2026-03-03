import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.onPressed,
    this.title,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.titleStyle,
    this.style,
    this.gradient,
    this.backgroundColor,   // ← pass this to override gradient entirely
    this.borderRadius,
    this.boxShadow,
    this.leading,
    this.trailing,
    this.spacing,
    this.mainAxisAlignment,
  });

  final VoidCallback? onPressed;
  final String? title;
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleStyle;
  final ButtonStyle? style;
  final Gradient? gradient;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? leading;
  final Widget? trailing;
  final double? spacing;
  final MainAxisAlignment? mainAxisAlignment;

  // WHY getter: clean, reusable, not rebuilt every time
  Gradient get _defaultGradient => LinearGradient(
        colors: [AppColors.primary, AppColors.primaryDark],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  List<BoxShadow> get _defaultShadow => [
        BoxShadow(
          color: AppColors.primaryDark.withValues(alpha: 0.20),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(12.r);
    final content = child ?? _buildDefaultChild();

    return Container(
      width: width ?? double.infinity,
      height: height ?? 52.h,       // ← 52 matches Figma better than 64
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius,

        // WHY this logic:
        // backgroundColor passed → solid color, no gradient
        // backgroundColor null  → use gradient (default or custom)
        gradient: backgroundColor != null
            ? null
            : (gradient ?? _defaultGradient),
        color: backgroundColor,     // null if gradient is used

        boxShadow: boxShadow ?? _defaultShadow,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: _buildStyle(radius).merge(style),
        child: content,
      ),
    );
  }

  ButtonStyle _buildStyle(BorderRadiusGeometry radius) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent, // container handles color
      foregroundColor: Colors.white,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: radius),
      textStyle: titleStyle ??
          TextStyle(
            fontSize: 16.sp,              // ← fixed from 22
            fontWeight: FontWeight.w600,  // ← w600 not w700 (less heavy)
            color: Colors.white,
          ),
    );
  }

  Widget _buildDefaultChild() {
    final double gap = spacing ?? 8.w;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(width: gap),
        ],
        Text(
          title ?? 'Get started',
          style: titleStyle ??
              TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
        ),
        if (trailing != null) ...[
          SizedBox(width: gap),
          trailing!,
        ],
      ],
    );
  }
}