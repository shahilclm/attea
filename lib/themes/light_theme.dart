// import '../ants/ants.dart';
import '../constants/constants.dart';
import '../services/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/app_theme_extensions.dart';

final lightTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  brightness: Brightness.light,
  scaffoldBackgroundColor: CustomColors.backgroundColor,
  useMaterial3: true,
  extensions: [
    AppThemeColors(
      secondaryColor: const Color.fromARGB(255, 221, 221, 220),

      dynamicIconColor: Colors.black,
      primary: CustomColors.primaryColor,
      background: CustomColors.textColorLight,
      textContrastColor: Colors.black87,
      textGrey: Colors.grey,
      textLightGrey: CustomColors.textColorLightGrey,
    ),
  ],
  navigationBarTheme: NavigationBarThemeData(
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
    ),
    height: kBottomNavigationBarHeight,
    backgroundColor: Color(0xFFF5F5F5),
    indicatorColor: Color(0xFF3AB54A),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(color: Color(0xFF3AB54A), size: 24.v),
    ),
  ),
  dividerTheme: DividerThemeData(
    thickness: 0.7,
    color: Color(0xFFD3D3D3),
    endIndent: 40,
    indent: 40,
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: CustomColors.backgroundColor,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Color(0xFFF5F5F5)),

    backgroundColor: Color(0xFFF5F5F5),
    foregroundColor: Colors.black87,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 18.fSize,
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: CustomColors.textColorLight,
    filled: true,
    hintStyle: TextStyle(
      color: CustomColors.textColorGrey,
      fontWeight: FontWeight.w500,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        CustomPadding.paddingXL,
      ), // Pill shape
      borderSide: BorderSide.none, // No visible border
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(CustomPadding.paddingXL),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(CustomPadding.paddingXL),
      borderSide: BorderSide.none,
    ),
  ),
);
