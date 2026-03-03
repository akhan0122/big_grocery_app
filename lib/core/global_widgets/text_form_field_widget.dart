// lib/core/global_widgets/text_form_field_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText, // ← required now, no misleading default
    this.prefixIcon, // ← configurable icon
    this.isPassword = false, // ← default false (most fields aren't passwords)
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon; // ← NEW: caller decides the icon
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool enabled;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword; // starts hidden only if isPassword
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      obscureText: _obscureText,
      style: TextStyle(
        fontSize: 16.sp, // ← ScreenUtil
        color: AppColors.inputFieldText,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputFieldFill,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 16.sp, // ← ScreenUtil
          color: AppColors.inputFieldHint,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h, // ← ScreenUtil
          horizontal: 12.w, // ← added horizontal too
        ),

        // ← uses whatever icon caller passes
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: AppColors.inputFieldIcon,
                size: 20.r, // ← ScreenUtil
              )
            : null,

        // eye icon only shows on password fields
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.inputFieldIcon,
                  size: 20.r, // ← ScreenUtil
                ),
              )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // ← ScreenUtil
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: AppColors.primary, // ← subtle focus indicator
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          // ← NEW: shows red on validation fail
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
