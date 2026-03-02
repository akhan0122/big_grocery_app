import 'package:flutter/material.dart';

extension AppTextStyles on BuildContext {
  TextTheme get _textTheme => Theme.of(this).textTheme;

  TextStyle? get titleText => _textTheme.titleLarge;
  TextStyle? get bodyText => _textTheme.bodyMedium;
  TextStyle? get smallText => _textTheme.bodySmall;
}
