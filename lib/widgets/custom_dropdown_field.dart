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
      padding: const EdgeInsets.all(0),
      child: DropdownButtonFormField<T>(
        padding: EdgeInsets.symmetric(horizontal: CustomPadding.paddingXL),
        value: value,
        isExpanded: isExpanded,
        decoration: InputDecoration(
          isDense: true,
          // labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
        items: items,
        onChanged: onChanged,
        validator: validator,
        dropdownColor: CustomColors.textColorGrey,
        style: TextStyle(
          color: CustomColors.textColorLight,
          fontFamily: CustomFont.intelOneMono,
          fontSize: 18,
        ),
        selectedItemBuilder: (BuildContext context) {
          return items.map<Widget>((DropdownMenuItem<T> item) {
            return Text(
              item.value.toString(),
              style: TextStyle(
                color: CustomColors
                    .textColorDark, // Custom color for the selected text
                fontSize: 18,
                fontFamily: CustomFont.intelOneMono,
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
