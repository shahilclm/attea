import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<Map<String, dynamic>> getDeviceDetails() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return {
        'brand': info.brand,
        'model': info.model,
        'name': info.name,
        'manufacturer': info.manufacturer,
        'version': info.version.release,
        'sdk': info.version.sdkInt,
      };
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return {
        'name': info.name,
        'model': info.model,
        'systemVersion': info.systemVersion,
        'identifierForVendor': info.identifierForVendor,
      };
    }
    return {'error': 'Unsupported platform'};
  }
}
