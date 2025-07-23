import 'package:flutter/material.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {

  final Color secondaryColor;
  final Color primary;
  final Color background;
  final Color textContrastColor;
  final Color textGrey;
  final Color textLightGrey;
  final Color dynamicIconColor;

  const AppThemeColors( {
    required this.secondaryColor,
    required this.primary,
    required this.background,
    required this.textContrastColor,
    required this.textGrey,
    required this.textLightGrey,
    required this.dynamicIconColor,
  });

  @override
  AppThemeColors copyWith({
    Color? secondaryColor,
    Color? primary,
    Color? background,
    Color? textContrastColor,
    Color? textGrey,
    Color? textLightGrey,
    Color? dynamicIconColor,
  }) {
    return AppThemeColors(
      secondaryColor : secondaryColor ?? this.secondaryColor,
      dynamicIconColor: dynamicIconColor ?? this.dynamicIconColor,
      primary: primary ?? this.primary,
      background: background ?? this.background,
      textContrastColor: textContrastColor ?? this.textContrastColor,
      textGrey: textGrey ?? this.textGrey,
      textLightGrey: textLightGrey ?? this.textLightGrey,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      secondaryColor:Color.lerp(secondaryColor,other.secondaryColor,t)!,
      dynamicIconColor:
          Color.lerp(dynamicIconColor, other.dynamicIconColor, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      textContrastColor:
          Color.lerp(textContrastColor, other.textContrastColor, t)!,
      textGrey: Color.lerp(textGrey, other.textGrey, t)!,
      textLightGrey: Color.lerp(textLightGrey, other.textLightGrey, t)!,
    );
  }
}
