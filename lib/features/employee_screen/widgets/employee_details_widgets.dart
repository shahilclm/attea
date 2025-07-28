import 'package:attea/exporter/exporter.dart';
import 'package:attea/extensions/app_theme_extensions.dart';
import 'package:attea/features/employee_screen/models/employee_model.dart';
import 'package:attea/features/employee_screen/widgets/employee_detail_helper.dart';
import 'package:attea/services/text_caps.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EmployeeDetailsWidgets {
  static Widget buildNameSection({
    required Employee employee,
    required bool isEditMode,
    required TextEditingController nameController,
    required AppThemeColors appColors,
  }) {
    if (isEditMode) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: CustomPadding.paddingLarge),
        child: TextField(
          controller: nameController,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: appColors.textContrastColor,
            fontFamily: CustomFont.intelOneMono,
            fontSize: 24.fSize,
          ),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: appColors.primary, width: 2),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: appColors.textLightGrey),
            ),
          ),
        ),
      );
    }

    return Text(
      TextCaps.toTitleCase(employee.name),
      style: TextStyle(
        color: appColors.textContrastColor,
        fontFamily: CustomFont.intelOneMono,
        fontSize: 24.fSize,
      ),
    );
  }

  static Widget buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required String fieldKey,
    required AppThemeColors appColors,
    required bool isEditMode,
    required Map<String, TextEditingController> controllers,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    bool isDropdown = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(CustomPadding.padding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
          color: appColors.secondaryColor,
          border: isEditMode
              ? Border.all(
                  color: appColors.primary.withValues(alpha: 0.3),
                  width: 1,
                )
              : null,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: appColors.textLightGrey,
            child: Icon(icon, color: CustomColors.kDarkDividerColor),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: appColors.textContrastColor,
              fontFamily: CustomFont.intelOneMono,
            ),
          ),
          subtitle: isEditMode
              ? _buildEditWidget(
                  fieldKey: fieldKey,
                  controllers: controllers,
                  keyboardType: keyboardType,
                  isDropdown: isDropdown,
                  appColors: appColors,
                )
              : Text(
                  value,
                  style: TextStyle(
                    color: appColors.textGrey,
                    fontFamily: CustomFont.intelOneMono,
                  ),
                ),
          onTap: onTap,
          trailing: isEditMode
              ? Icon(LucideIcons.edit2, size: 16, color: appColors.primary)
              : (onTap != null
                    ? Icon(
                        EmployeeDetailsHelpers.getTrailingIcon(title),
                        size: 16,
                        color: appColors.primary,
                      )
                    : null),
        ),
      ),
    );
  }

  static Widget _buildEditWidget({
    required String fieldKey,
    required Map<String, TextEditingController> controllers,
    required AppThemeColors appColors,
    TextInputType? keyboardType,
    bool isDropdown = false,
  }) {
    if (isDropdown && fieldKey == 'category') {
      return _buildCategoryDropdown(controllers, appColors);
    }

    return TextField(
      controller: controllers[fieldKey],
      keyboardType: keyboardType,
      style: TextStyle(
        color: appColors.textContrastColor,
        fontFamily: CustomFont.intelOneMono,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: appColors.primary, width: 2),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: appColors.textLightGrey),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }

  static Widget _buildCategoryDropdown(
    Map<String, TextEditingController> controllers,
    AppThemeColors appColors,
  ) {
    final categories = Employee.availableCategories;

    String? currentValue = controllers['category']!.text.isNotEmpty
        ? controllers['category']!.text
        : null;

    if (currentValue != null && !categories.contains(currentValue)) {
      currentValue = null;
    }

    return DropdownButtonFormField<String>(
      value: currentValue,
      dropdownColor: appColors.background,
      isExpanded: true,
      style: TextStyle(
        color: appColors.textContrastColor,
        fontFamily: CustomFont.intelOneMono,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: appColors.primary, width: 2),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: appColors.textLightGrey),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8),
      ),
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(
            category,
            style: TextStyle(
              color: appColors.textContrastColor,
              fontFamily: CustomFont.intelOneMono,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          controllers['category']!.text = value;
          print('Category changed to: $value');
        }
      },
    );
  }

  static Widget buildDateCard({
    required Employee employee,
    required bool isEditMode,
    required DateTime? selectedDob,
    required AppThemeColors appColors,
    required VoidCallback onDateTap,
  }) {
    final displayDate = isEditMode
        ? (selectedDob ?? employee.dob)
        : employee.dob;

    final hasDateChanged = selectedDob != null && selectedDob != employee.dob;

   

    return Padding(
      padding: const EdgeInsets.all(CustomPadding.padding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
          color: appColors.secondaryColor,
          border: isEditMode
              ? Border.all(
                  color: hasDateChanged
                      ? appColors.primary.withValues(alpha: 0.6)
                      : appColors.primary.withValues(alpha: 0.3),
                  width: hasDateChanged ? 2 : 1,
                )
              : null,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: appColors.textLightGrey,
            child: Icon(
              Icons.date_range,
              color: CustomColors.kDarkDividerColor,
            ),
          ),
          title: Text(
            'Date Of Birth',
            style: TextStyle(
              color: appColors.textContrastColor,
              fontFamily: CustomFont.intelOneMono,
            ),
          ),
          subtitle: isEditMode
              ? InkWell(
                  onTap: onDateTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: hasDateChanged
                              ? appColors.primary
                              : appColors.textLightGrey,
                          width: hasDateChanged ? 2 : 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(displayDate),
                          style: TextStyle(
                            color: hasDateChanged
                                ? appColors.primary
                                : appColors.textContrastColor,
                            fontFamily: CustomFont.intelOneMono,
                            fontWeight: hasDateChanged
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        if (hasDateChanged) ...[
                          Gap(8),
                          Icon(Icons.edit, size: 14, color: appColors.primary),
                        ],
                        Spacer(),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: appColors.primary,
                        ),
                      ],
                    ),
                  ),
                )
              : Text(
                  DateFormat('dd/MM/yyyy').format(displayDate),
                  style: TextStyle(
                    color: appColors.textGrey,
                    fontFamily: CustomFont.intelOneMono,
                  ),
                ),
          trailing: isEditMode
              ? Icon(
                  LucideIcons.edit2,
                  size: 16,
                  color: hasDateChanged
                      ? appColors.primary
                      : appColors.textGrey,
                )
              : null,
        ),
      ),
    );
  }

  static Widget buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }
}
