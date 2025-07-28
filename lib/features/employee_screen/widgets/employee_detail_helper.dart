import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EmployeeDetailsHelpers {
  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'flutter':
        return Icons.phone_android;
      case 'backend':
        return Icons.dns;
      case 'web':
        return Icons.web;
      case 'digital marketing':
        return Icons.campaign;
      case 'interns':
        return Icons.school;
      case 'testers':
        return Icons.bug_report;
      default:
        return Icons.work;
    }
  }

  static IconData getTrailingIcon(String title) {
    switch (title.toLowerCase()) {
      case 'phone number':
        return Icons.call;
      case 'whatsapp number':
        return LucideIcons.messageCircle;
      case 'email':
        return Icons.email;
      default:
        return Icons.arrow_forward_ios;
    }
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static String? validateEmployeeData(
    Map<String, TextEditingController> controllers,
  ) {
    if (controllers['name']!.text.trim().isEmpty) {
      return 'Name cannot be empty';
    }

    if (controllers['email']!.text.trim().isEmpty ||
        !isValidEmail(controllers['email']!.text.trim())) {
      return 'Please enter a valid email';
    }

    if (controllers['phone']!.text.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

    if (controllers['whatsapp']!.text.trim().isEmpty) {
      return 'WhatsApp number cannot be empty';
    }

    if (controllers['role']!.text.trim().isEmpty) {
      return 'Role cannot be empty';
    }

    if (controllers['category']!.text.trim().isEmpty) {
      return 'Category cannot be empty';
    }

    return null; 
  }
}
