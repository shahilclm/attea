import '/services/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extensions/app_theme_extensions.dart';
import 'light_theme.dart';
import '../constants/constants.dart';

final ThemeData darkTheme = lightTheme.copyWith(
  extensions: [
    AppThemeColors(
      secondaryColor: CustomColors.kSecondaryDark,
      dynamicIconColor: Color(0xffE2E2E2),
      primary: CustomColors.primaryColor,
      background: CustomColors.kDarkScaffold,
      textContrastColor: CustomColors.textColorLight,
      textGrey: Colors.grey,
      textLightGrey: CustomColors.textColorLightGrey,
    ),
  ],
  scaffoldBackgroundColor: CustomColors.kDarkScaffold,
  brightness: Brightness.dark,
  // scaffoldBackgroundColor: Colors.black87,
  navigationBarTheme: lightTheme.navigationBarTheme.copyWith(
    backgroundColor: CustomColors.kDarkBottomNav,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        color: CustomColors.textColorDark,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(
        color: CustomColors.primaryColor,
        size: 24.v,
      ),
    ),
  ),
  dividerTheme:
      lightTheme.dividerTheme.copyWith(color: CustomColors.kDarkDividerColor),
  appBarTheme: lightTheme.appBarTheme.copyWith(
    surfaceTintColor: CustomColors.kDarkDividerColor,
    backgroundColor: CustomColors.kDarkScaffold,
    // color: CustomColors.kDarkAppBar,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: CustomColors.kDarkAppBar,
      statusBarIconBrightness: Brightness.light,
    ),
    // backgroundColor: CustomColors.kDarkScaffold,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 18.fSize,
      fontWeight: FontWeight.w500,
      color: CustomColors.textColorDark,
      // fontSize: 18.fSize,
      // fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
    hintStyle: TextStyle(
      color: CustomColors.textColorGrey,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
      borderSide: const BorderSide(
        color: Colors.transparent,
        // width: 1.0,
      ),
    ),
  ),
);
