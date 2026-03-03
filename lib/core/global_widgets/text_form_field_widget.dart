import 'package:flutter/material.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.hintText = 'Password',
    this.isPassword = true,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.enabled = true,
  });
  final TextEditingController controller;
  final String hintText;
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
    _obscureText = widget.isPassword;
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
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.inputFieldText,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputFieldFill,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: AppColors.inputFieldHint,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppColors.inputFieldIcon,
        ),
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
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
