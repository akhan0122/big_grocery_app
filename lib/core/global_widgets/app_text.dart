import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    this.text,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.height,
    this.letterSpacing,
    this.wordSpacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.textScaler,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.semanticsLabel,
    this.padding,
    this.margin,
    this.backgroundColor,
  });

  final String? text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final double? height;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final String? semanticsLabel;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveStyle =
        const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )
            .copyWith(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontFamily: fontFamily,
              height: height,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              decoration: decoration,
              decorationColor: decorationColor,
              decorationThickness: decorationThickness,
            )
            .merge(style);

    final Widget textWidget = Text(
      text ?? '',
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      textScaler: textScaler,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      semanticsLabel: semanticsLabel,
    );

    if (padding == null && margin == null && backgroundColor == null) {
      return textWidget;
    }

    return Container(
      padding: padding,
      margin: margin,
      color: backgroundColor,
      child: textWidget,
    );
  }
}
