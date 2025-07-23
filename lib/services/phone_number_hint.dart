import '/core/logger.dart';
import 'package:flutter/services.dart';

class PhoneNumberHint {
  static const MethodChannel _channel = MethodChannel('mobile_number_hint');

  static Future<String?> getPhoneNumber() async {
    try {
      final phoneNumber = await _channel.invokeMethod<String>('getPhoneNumber');
      return phoneNumber;
    } catch (e) {
      logError("Error fetching phone number: $e");
      return null;
    }
  }
}
