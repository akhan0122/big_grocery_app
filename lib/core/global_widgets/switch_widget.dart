// lib/core/global_widgets/app_toggle_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';

class AppToggleWidget extends StatelessWidget {
  const AppToggleWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.width,
    this.height,
    this.thumbSize,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  // ── Colors — all optional ──────────────────────────────────
  final Color? activeColor; // track color when ON
  final Color? inactiveTrackColor; // track color when OFF
  final Color? thumbColor; // thumb color (both states)
  final Color? activeThumbColor; // thumb when ON  (overrides thumbColor)
  final Color? inactiveThumbColor; // thumb when OFF (overrides thumbColor)

  // ── Size — all optional ────────────────────────────────────
  final double? width;
  final double? height;
  final double? thumbSize;

  // ── Internal resolvers ─────────────────────────────────────
  double get _width => width ?? 36.w;
  double get _height => height ?? 20.h;
  double get _thumbSize => thumbSize ?? 14.r;
  double get _padding => (_height - _thumbSize) / 2;

  Color get _trackColor => value
      ? (activeColor ?? AppColors.primary)
      : (inactiveTrackColor ?? const Color(0xFFDDDDDD));

  Color get _thumbColor => value
      ? (activeThumbColor ?? thumbColor ?? Colors.white)
      : (inactiveThumbColor ?? thumbColor ?? Colors.white);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _width,
        height: _height,
        padding: EdgeInsets.all(_padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: _trackColor,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: _thumbSize,
            height: _thumbSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _thumbColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
