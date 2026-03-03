import '../../../utils/app_exports.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      this.hintText,
      required this.textEditingController,
      this.inputType = TextInputType.text,
      this.validator,
      this.suffixIconColor,
      this.suffixIconSize,
      this.borderRadius = AppStyles.globalRadius,
      this.suffixIcon,
      this.prefixIcon,
      this.inputFormatters,
      this.textCapitalization = TextCapitalization.none,
      this.obscureText = false,
      this.maxLength,
      this.onSubmit,
      this.suffixOnTap,
      this.isMandatory = false,
      this.showMandatoryLabel = false,
      this.label = "",
      this.onChanged,
      this.maxHeight = 500,
      this.enabled = true,
      this.readOnly = false,
      this.prefixIconSize,
      this.isShowCounter = false,
      this.suffixWidget,
      this.suffixWidthConstraint,
      this.prefixWidget,
      this.minLines = 1,
      this.maxLines = 1,
      this.fillColor,
      this.focusNode,
      this.contentTextColor,
      this.onTap,
      this.hintColor,
      this.onLabelIconTap,
      this.labelWithIconText = "",
      this.isColonText = true,
      this.labelBottom,
      this.labelBottomPadding,
      this.borderColor,
      this.inputDecoration,
      this.textAlign = TextAlign.start,
      this.onEditingComplete,
      this.focusBorderColor,
      this.maxHeightEnable = true,
      this.autofocus = false});
  final String? hintText;

  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  final bool obscureText;
  final Color? suffixIconColor, fillColor, hintColor;
  final double? suffixIconSize;
  final double borderRadius;
  final double? suffixWidthConstraint;
  final String? suffixIcon;
  final String? prefixIcon;
  final double? prefixIconSize, labelBottom, labelBottomPadding;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final Function(String)? onSubmit;
  final Function()? onEditingComplete;
  final Function()? suffixOnTap, onTap, onLabelIconTap;
  final bool isMandatory;
  final bool showMandatoryLabel;
  final String label, labelWithIconText;
  final Function(String)? onChanged;
  final double maxHeight;
  final bool isShowCounter, enabled, readOnly, isColonText;
  final Widget? suffixWidget, prefixWidget;
  final int minLines;
  final int maxLines;
  final Color? contentTextColor, borderColor, focusBorderColor;
  final FocusNode? focusNode;
  final InputDecoration? inputDecoration;
  final TextAlign textAlign;
  final bool maxHeightEnable;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 5, bottom: labelBottomPadding ?? 5),
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: label,
                style: context.titleLarge,
                children: [
                  TextSpan(
                      text: isMandatory
                          ? showMandatoryLabel
                              ? " (Required)"
                              : '*'
                          : "",
                      style: showMandatoryLabel
                          ? context.bodySmall!.copyWith(color: Colors.red)
                          : context.titleLarge!.copyWith(color: Colors.red)),
                  TextSpan(
                      text: isColonText ? ':' : '', style: context.titleLarge)
                ],
              ),
            ),
          ),
        if (labelWithIconText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: labelWithIconText,
                      style: context.titleLarge,
                      children: [
                        TextSpan(
                            text: isMandatory
                                ? showMandatoryLabel
                                    ? " (Required)"
                                    : '*'
                                : "",
                            style: showMandatoryLabel
                                ? context.bodySmall!.copyWith(color: Colors.red)
                                : context.titleLarge!
                                    .copyWith(color: Colors.red)),
                        TextSpan(
                            text: isColonText ? ':' : '',
                            style: context.titleLarge)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                inkWellEffect(
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.instance.getColor65),
                      child: Center(
                          child: Icon(
                        Icons.add,
                        size: 16.0,
                        color: AppColors.instance.white,
                      )),
                    ),
                    onLabelIconTap,
                    0),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
        maxHeightEnable == false
            ? _textFieldWidget(context: context)
            : ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: _textFieldWidget(context: context)),
      ],
    );
  }

  Widget _textFieldWidget({required BuildContext context}) {
    return TextFormField(
      autofocus: autofocus,
      textAlign: textAlign,
      onTap: onTap,
      readOnly: readOnly,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onSubmit,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      style: context.titleLarge?.copyWith(color: contentTextColor),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textEditingController,
      keyboardType: inputType,
      validator: validator,
      minLines: minLines,
      maxLines: minLines,
      maxLength: maxLength,
      cursorColor: context.primaryColor,
      obscureText: obscureText,
      buildCounter: (context,
          {required currentLength, required isFocused, maxLength}) {
        return null;
      },
      decoration: inputDecoration ??
          InputDecoration(
            enabled: enabled,
            hoverColor: AppColors.instance.white,
            counterStyle: TextStyle(fontSize: isShowCounter ? 10 : 0),
            hintStyle: context.titleLarge?.copyWith(
                color: hintColor ?? AppColors.instance.getBodyOrHintColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
            hintText: hintText,
            prefixIcon: (prefixIcon ?? "").isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset(
                      prefixIcon ?? "",
                      colorFilter: ColorFilter.mode(
                          // AppColors.instance.getMainHeadingColor,
                          enabled
                              ? AppColors.instance.getMainHeadingColor
                              : AppColors.instance.getDividerColor,
                          BlendMode.srcIn),
                      height: prefixIconSize ?? 20,
                      width: prefixIconSize ?? 20,
                    ),
                  )
                : prefixWidget,
            prefixIconConstraints: const BoxConstraints(minWidth: 20),
            suffixIcon: (suffixIcon ?? "").isNotEmpty
                ? inkWellEffect(
                    SvgPicture.asset(
                      suffixIcon ?? "",
                      colorFilter: ColorFilter.mode(
                          enabled
                              ? suffixIconColor ??
                                  AppColors.instance.getMainHeadingColor
                              : AppColors.instance.getDividerColor,
                          BlendMode.srcIn),
                      height: suffixIconSize ?? 20,
                      width: suffixIconSize ?? 20,
                    ),
                    suffixOnTap,
                    5)
                : suffixWidget,
            suffixIconConstraints:
                BoxConstraints(minWidth: suffixWidthConstraint ?? 20),
            filled: true,
            fillColor: !enabled
                ? AppColors.instance.getNeutralColor100
                : fillColor ?? Colors.white,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color: AppColors.instance.getDividerColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color: borderColor ?? AppColors.instance.getDividerColor,
                  width: 1),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color: AppColors.instance.getErrorColor400, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color: AppColors.instance.getErrorColor400, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  width: 1.5,
                  color: focusBorderColor ??
                      AppColors.instance.getPrimaryColor500),
            ),
            errorStyle: TextStyle(color: AppColors.instance.getErrorColor400),
          ),
      onChanged: onChanged,
      onTapOutside: (value) {
        // debugPrint("ok");
      },
      
    );
  }

  Padding inkWellEffect(Widget child, Function()? onTap, double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onTap,
          splashColor: AppColors.instance.getPrimaryColor300,
          hoverColor: AppColors.instance.getPrimaryColor100,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: child,
          ),
        ),
      ),
    );
  }
}
