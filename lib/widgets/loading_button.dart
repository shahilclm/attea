import '/exporter/exporter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ButtonType {
  outlined,
  filled;

  BoxBorder? get border {
    switch (this) {
      case ButtonType.outlined:
        return Border.all(color: const Color(0xffC9C9C9), width: 1);
      case ButtonType.filled:
        return null;
    }
  }

  LinearGradient get gradient => CustomColors.fruitlyGradient;

  Color? get color {
    switch (this) {
      case ButtonType.outlined:
        return Colors.transparent;
      case ButtonType.filled:
        return null;
    }
  }

  Color get textColor {
    switch (this) {
      case ButtonType.outlined:
        return const Color(0xff000000);
      case ButtonType.filled:
        return Colors.white;
    }
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.buttonLoading,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.expanded = true,
    this.textColor,
    this.backgroundColor,
    this.buttonType = ButtonType.filled,
    this.icon,
    this.aspectRatio = 60 / 47,
    this.height = 56,
    this.maxWidth = 300,
  });

  final bool buttonLoading;
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final bool expanded;
  final Color? textColor;
  final Color? backgroundColor;
  final ButtonType buttonType;
  final Widget? icon;
  final double aspectRatio;
  final double height;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(CustomPadding.paddingXL);
    final effectiveTextColor = textColor ?? buttonType.textColor;

    final Widget content = MouseRegion(
      cursor: enabled && !buttonLoading
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: Container(
        height: height,
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          border: buttonType.border,
          gradient: backgroundColor != null ? null : buttonType.gradient,
          color: backgroundColor ?? buttonType.color,
          borderRadius: borderRadius,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: buttonLoading || !enabled
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    HapticFeedback.lightImpact();
                    onPressed();
                  },
            child: Center(
              child: buttonLoading
                  ? SizedBox(
                      width: 20.h,
                      height: 20.v,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[icon!, SizedBox(width: 8.h)],
                        Text(
                          text,
                          style: context.labelLarge.copyWith(
                              fontSize: 15.fSize,
                              fontWeight: FontWeight.bold,
                              color: effectiveTextColor),
                          // Theme.of(context).labelLarge.copyWith(
                          //       fontSize: 15.fSize,
                          //       fontWeight: FontWeight.w800,
                          //       color: effectiveTextColor,
                          //     ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );

    return expanded
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(fit: FlexFit.loose, child: content),
            ],
          )
        : content;
  }
}
