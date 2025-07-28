import 'package:attea/exporter/exporter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Redirect {
  static Future<void> makePhoneCall(String phoneNumber) async {
  if (phoneNumber.isEmpty) {
    Fluttertoast.showToast(
      msg: 'Phone number not available',
      backgroundColor: CustomColors.textColorGrey,
      gravity: ToastGravity.TOP,
    );

    return;
  }

  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

  try {
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Fluttertoast.showToast(
        msg: 'Could not launch phone dialer',
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Error: Could not make phone call',
      backgroundColor: CustomColors.scaffoldRed,
      gravity: ToastGravity.TOP,
    );
  }
}
static Future<void> openWhatsApp(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
     Fluttertoast.showToast(
        msg: 'WhatsApp number not available',
        backgroundColor: CustomColors.primaryColor,
        gravity: ToastGravity.TOP,
      );
      return;
    }

    
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

   
    if (!cleanNumber.startsWith('+')) {
      cleanNumber = '+91$cleanNumber'; 
    }

    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanNumber');

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        Fluttertoast.showToast(
          msg: 'Whatsapp is not installed',
          backgroundColor: CustomColors.primaryColor,
          gravity: ToastGravity.TOP,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: Could not open WhatsApp',
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
   
    }
  }

}

