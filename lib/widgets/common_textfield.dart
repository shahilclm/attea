import '/constants/constants.dart';
import '/extensions/app_theme_extensions.dart';
import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {

  final IconData? prefixIcon;
  final IconData? sufixIcon;
  final String hintText;
  final VoidCallback? onSuffixTap;
  final double elevation;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final bool obscureText;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool autofocus;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Color? fillColor;

  const CommonTextfield({
    super.key,
    this.prefixIcon,
    required this.hintText,
    this.controller,
    this.sufixIcon,
    this.onSuffixTap,
    this.prefixIconColor,
    this.suffixIconColor,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.validator,
    this.isRequired = false,
    this.autofocus = false,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.elevation = 1,
    this.fillColor, 
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        // horizontal: CustomPadding.paddingLarge,
      ),
      child: Material(
        borderRadius: BorderRadius.all(
          Radius.circular(CustomPadding.paddingXL),
        ),
        elevation: elevation,
        shadowColor: appColors.dynamicIconColor,
        child: TextFormField(
          // initialValue: initialValue ?? '',
          autofocus: autofocus,
          readOnly: readOnly,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          maxLines: obscureText ? 1 : maxLines,
          minLines: obscureText ? 1 : minLines,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            fillColor: fillColor,
            prefixIcon: Icon(
              prefixIcon,
              color: appColors.textContrastColor.withValues(alpha: 0.5),
            ),
            suffixIcon: sufixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(right: CustomPadding.paddingLarge),
                    child: IconButton(
                      onPressed: onSuffixTap,
                      icon: Icon(
                        sufixIcon,
                        color: appColors.dynamicIconColor.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  )
                : null,

            hintText: hintText,
            hintStyle: TextStyle(
              color: appColors.dynamicIconColor.withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
              fontFamily: CustomFont.intelOneMono,
            ),
          ),
        ),
      ),
    );
  }
}
