import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

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
    this.backgroundColor,
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

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(8);
    final Widget effectiveChild = child ?? _buildDefaultChild();

    return Container(
      width: width ?? double.infinity,
      height: height ?? 64,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        gradient:
            gradient ??
            LinearGradient(
              colors: [
                AppColors.primary,
                backgroundColor ?? AppColors.primaryDark,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
        color: gradient == null ? backgroundColor : null,
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: AppColors.primaryDark.withValues(alpha: 0.20),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: _defaultStyle(effectiveBorderRadius).merge(style),
        child: effectiveChild,
      ),
    );
  }

  ButtonStyle _defaultStyle(BorderRadiusGeometry radius) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: radius),
      textStyle:
          titleStyle ??
          const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
    );
  }

  Widget _buildDefaultChild() {
    final double gap = spacing ?? 10;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        if (leading != null) leading!,
        if (leading != null) SizedBox(width: gap),
        Text(title ?? 'Get started', style: titleStyle),
        if (trailing != null) SizedBox(width: gap),
        if (trailing != null) trailing!,
      ],
    );
  }
}
