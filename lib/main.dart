import 'package:attea/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '/core/localization/localization_service.dart';
import '/services/get_device_details.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/exporter/exporter.dart';
import '/features/splash_screen/splash_screen.dart';
import '/routes/app_routes.dart';
import '/themes/dark_theme.dart';
import '/core/api/dio_helper.dart';
import '/services/shared_pref_services.dart';
import 'package:flutter/material.dart';
import 'themes/light_theme.dart';

LocalizationService localizationService = LocalizationService('en');
final navigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<MyAppState> appKey = GlobalKey<MyAppState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logError("⚠️ Calling SharedPreferencesService.initialize()");
  await SharedPreferencesService.i.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await DioHelper().init();
  final deviceDetails = await DeviceInfoService.getDeviceDetails();
  logInfo(deviceDetails);

  runApp(MyApp(key: appKey));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void toggleTheme() {
    appKey.currentState?.toggleTheme();
  }

  static void setLanguage(String langCode) {
    appKey.currentState?.setLanguage(langCode);
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    logWarning('Toggling theme to ${_isDarkMode ? 'light' : 'dark'} mode');
    setState(() => _isDarkMode = !_isDarkMode);
  }

  void setLanguage(String langCode) {
    setState(() {
      localizationService = LocalizationService(langCode);
      logInfo("Language changed to $langCode");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en', ''), Locale('ml', '')],
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.path,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoute,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
