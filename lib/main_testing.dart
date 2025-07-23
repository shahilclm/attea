import '/core/logger.dart';
import '/services/shared_pref_services.dart';
import 'package:flutter/material.dart';
import 'core/api/base_url_constant.dart';
import 'flavors/flutter_flavors.dart';
import 'main.dart';

Future<void> main() async {
  FlavorConfig.initialize(FlavorConfig(
    flavor: Flavor.testing,
    // baseUrl: 'https://debug.example.com/base',
    name: 'TESTING',
  ));
  String api = BaseUrlConstant.getBaseUrl(ApiType.baseUrl);
  logWarning('Calling API: $api');

  WidgetsFlutterBinding.ensureInitialized();
  // logError("⚠️ Calling SharedPreferencesService.initialize()");
  await SharedPreferencesService.i.initialize();
  runApp(MyApp(key: appKey));
}
