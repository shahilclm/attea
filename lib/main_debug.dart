import 'package:attea/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import '/core/logger.dart';
import '/services/shared_pref_services.dart';
import 'package:flutter/material.dart';
import 'core/api/base_url_constant.dart';
import 'flavors/flutter_flavors.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  FlavorConfig.initialize(
    const FlavorConfig(
      // baseUrl: 'https://debug.example.com/shahil',
      flavor: Flavor.debug,
      name: 'DEBUG',
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  logError("⚠️ Calling SharedPreferencesService.initialize()");
  await SharedPreferencesService.i.initialize();

  String api = BaseUrlConstant.getBaseUrl(ApiType.baseUrl);
  logWarning('Calling API: $api');

  runApp(MyApp(
    key: appKey,
  ));
}
