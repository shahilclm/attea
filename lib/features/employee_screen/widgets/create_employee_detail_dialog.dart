import 'package:attea/exporter/exporter.dart';
import 'package:attea/extensions/app_theme_extensions.dart';
import 'package:attea/features/employee_screen/models/employee_model.dart';
import 'package:attea/widgets/mini_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployeeDetailsDialogs {
  static Future<bool> showDeleteConfirmation({
    required BuildContext context,
    required Employee employee,
  }) async {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: appColors.background,
            title: Text(
              'Delete Employee',
              style: TextStyle(
                color: appColors.textContrastColor,
                fontFamily: CustomFont.intelOneMono,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Are you sure you want to delete ${employee.name}? This action cannot be undone.',
              style: TextStyle(
                color: appColors.textGrey,
                fontFamily: CustomFont.intelOneMono,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: appColors.textGrey,
                    fontFamily: CustomFont.intelOneMono,
                  ),
                ),
              ),
              MiniLoadingButton(
                text: 'Delete',
                onPressed: () => Navigator.pop(context, true),
                backgroundColor: CustomColors.scaffoldRed,
                textColor: CustomColors.textColorLight,
                fontFamily: CustomFont.intelOneMono,
              ),
              // ElevatedButton(
              //   onPressed: () => Navigator.pop(context, true),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: CustomColors.scaffoldRed,
              //     foregroundColor:CustomColors.textColorLight,
              //   ),
              //   child: Text(
              //     'Delete',
              //     style: TextStyle(
              //       fontFamily: CustomFont.intelOneMono,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ) ??
        false;
  }

  static Future<DateTime?> selectDate({
    required BuildContext context,
    DateTime? initialDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: CustomColors.primaryColor),
          ),
          child: child!,
        );
      },
    );

    logSuccess('Date picked: $picked');
    return picked;
  }

  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: CustomColors.scaffoldRed,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_LONG,
      textColor: CustomColors.textColorLight,
      fontSize: 16.0.fSize,
    );
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: CustomColors.green,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_SHORT,
      textColor: CustomColors.textColorLight,
      fontSize: 16.0.fSize,
    );
  }
}
