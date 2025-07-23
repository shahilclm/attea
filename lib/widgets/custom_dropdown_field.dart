import '/exporter/exporter.dart';
import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String? Function(T?)? validator;
  final void Function(T?) onChanged;
  final String? hintText;
  final bool isExpanded;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.hintText,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CustomPadding.paddingLarge),
      child: DropdownButtonFormField<T>(
        value: value,
        isExpanded: isExpanded,
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        items: items,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
