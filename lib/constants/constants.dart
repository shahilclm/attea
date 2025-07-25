import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomPadding {
  static const double padding = 8;
  static const double paddingLarge = 16;
  static const double paddingXL = 32;
  static const double paddingXXL = 64;
  static const double paddingSmall = 4;
  static const double paddingTiny = 2;
}

class CustomFont {
  static const String intelOneMono = 'IntelOneMono';
}

class CustomGap {
  static final gap = Gap(CustomPadding.padding);
  static final gapLarge = Gap(CustomPadding.paddingLarge);
  static final gapXL = Gap(CustomPadding.paddingXL);
  static final gapXXL = Gap(CustomPadding.paddingXXL);
  static final gapSmall = Gap(CustomPadding.paddingSmall);
  static final gapTiny = Gap(CustomPadding.paddingTiny);
}

class CustomDuration {
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration animationDurationLarge = Duration(seconds: 1);
}

class CustomColors {
  // === Light Theme Colors ===

  static const textFormFilledColor = Color.fromARGB(255, 173, 173, 173);
  static const primaryColor = Color(0xFF3AB54A);
  static const secondaryColor = Color(0xFFFEE440);
  static const tertiaryColor = Color(0xFFF0F0F0);

  static const backgroundColor = Color(0xFFf1F1F1);
  static const lightDarkColor = Color(0xff303030);
  static const textColor = Color(0xFF000000);
  static const textColorLight = Color(0xFFFFFFFF);
  static const textColorDark = Color(0xFF000000);
  static const textColorGrey = Color(0xFF808080);
  static const textColorLightGrey = Color(0xFFC8C8C8);
  static const textColorDarkGrey = Color(0xFF323232);

  static const textfieldphoneColors = Color(0xFFF0F8FF);
  static const scaffoldRed = Colors.red;

  // === Dark Theme Colors ===
  static const textFormFilledColorDark = Color.fromARGB(255, 172, 170, 170);
  static const kDarkScaffold = Color(0xFF0D0D0D);
  static const kDarkAppBar = Color(0xFF1F1F1F);
  static const kDarkDrawer = Color(0xFF1E1E1E);
  static const kDarkBottomNav = Color(0xFF1A1A1A);
  static const kDarkPrimary = Color(0xFFFFC107);
  static const kDarkTextColor = Colors.white70;
  static const kDarkTextFieldColor = Color(0xFF2C2C2C);

  static final kDarkDividerColor = Colors.grey[800];
  static final kDarkdynamicIconColor = Colors.white;
  static final kSecondaryDark = Color(0xff303030);
  static final darkBackgroundColor = Color(0xff1b1b1b);
  static final green = Colors.green;

  // === Gradients ===
  static const LinearGradient fruitlyGradient = LinearGradient(
    colors: [secondaryColor, primaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [
      Color(0xFFDA7A1F), // bright amber
      Color(0xFFAC580F), // base orange
      Color(0xFF7A3F0A), // deep rich
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [
      Color(0xFF66C870), // light green
      Color(0xFF3AB54A), // base
      Color(0xFF2A8F36), // dark green
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient newbuttonGradient = LinearGradient(
    colors: [
      primaryColor,
      Color(0xFFF1C14F), // yellow-gold
      Color(0xFFAC580F), // orange-brown
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

List profileImages = [
  "https://images.unsplash.com/photo-1712847331947-9460dd2f264b?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1580489944761-15a19d654956?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHBvcnRyYWl0fGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHBvcnRyYWl0fGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHBvcnRyYWl0fGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHBvcnRyYWl0fGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHBvcnRyYWl0fGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1554151228-14d9def656e4?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjN8fHBvcnRyYWl0fGVufDB8fDB8fHww",
];

String get randomProfileImage {
  List newList = List.from(profileImages);
  newList.shuffle();
  return newList.first;
}

List<String> firstNames = [
  "Emma",
  "Olivia",
  "Ava",
  "Isabella",
  "Sophia",
  "Mia",
  "Charlotte",
  "Amelia",
  "Harper",
  "Evelyn",
  "Liam",
  "Noah",
  "Oliver",
  "Elijah",
  "William",
  "James",
  "Benjamin",
  "Lucas",
  "Henry",
  "Alexander",
];

List<String> lastNames = [
  "Smith",
  "Johnson",
  "Williams",
  "Brown",
  "Jones",
  "Garcia",
  "Miller",
  "Davis",
  "Rodriguez",
  "Martinez",
  "Hernandez",
  "Lopez",
  "Gonzalez",
  "Wilson",
  "Anderson",
  "Thomas",
  "Taylor",
  "Moore",
  "Jackson",
  "Martin",
];

String get randomName {
  List<String> newFirstNames = List.from(firstNames);
  List<String> newLastNames = List.from(lastNames);

  newFirstNames.shuffle();
  newLastNames.shuffle();

  return "${newFirstNames.first} ${newLastNames.first}";
}

const dummyProfile =
    "https://t3.ftcdn.net/jpg/05/16/27/58/240_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg";
