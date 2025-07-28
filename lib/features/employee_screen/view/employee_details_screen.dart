import 'package:attea/exporter/exporter.dart';
import 'package:attea/extensions/app_theme_extensions.dart';
import 'package:attea/features/employee_screen/models/employee_model.dart';
import 'package:attea/features/employee_screen/services/employee_service.dart';
import 'package:attea/features/employee_screen/services/make_redirect.dart';
import 'package:attea/features/employee_screen/widgets/create_employee_detail_dialog.dart';
import 'package:attea/features/employee_screen/widgets/employee_avatar.dart';
import 'package:attea/features/employee_screen/widgets/employee_detail_helper.dart';
import 'package:attea/features/employee_screen/widgets/employee_details_widgets.dart';
import 'package:attea/services/text_caps.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  static const String path = '/employeeDetails';

  const EmployeeDetailsScreen({super.key});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late Employee _employee;
  bool _isEditMode = false;
  bool _isLoading = false;
  final Map<String, TextEditingController> _controllers = {};
  DateTime? _selectedDob;
  final EmployeeService _employeeService = EmployeeService();

  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _employee = ModalRoute.of(context)!.settings.arguments as Employee;
      _initializeControllers();
      _isInitialized = true;
    }
  }

  void _initializeControllers() {
    _controllers['name'] = TextEditingController(text: _employee.name);
    _controllers['email'] = TextEditingController(text: _employee.email);
    _controllers['phone'] = TextEditingController(text: _employee.phoneNumber);
    _controllers['whatsapp'] = TextEditingController(
      text: _employee.whatsappNumber,
    );
    _controllers['role'] = TextEditingController(text: _employee.role);
    _controllers['category'] = TextEditingController(text: _employee.category);

    _selectedDob = _employee.dob;

    _controllers.forEach((key, controller) {
      controller.addListener(() {});
    });
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      appBar: _buildAppBar(appColors),
      body: Column(
        children: [
          SafeArea(child: EmployeeAvatar(employeeUrl: _employee.photoUrl)),
          EmployeeDetailsWidgets.buildNameSection(
            employee: _employee,
            isEditMode: _isEditMode,
            nameController: _controllers['name']!,
            appColors: appColors,
          ),
          Text(
            TextCaps.toTitleCase(_employee.employeeId),
            style: TextStyle(
              color: appColors.textContrastColor,
              fontFamily: CustomFont.intelOneMono,
            ),
          ),
          Gap(CustomPadding.paddingLarge),
          _buildSectionTitle(appColors),
          Gap(CustomPadding.padding),
          Expanded(child: _buildDetailsList(appColors)),
        ],
      ),
    );
  }

  AppBar _buildAppBar(AppThemeColors appColors) {
    return AppBar(
      actions: [
        if (_isEditMode) ...[
          if (_isLoading)
            EmployeeDetailsWidgets.buildLoadingIndicator()
          else ...[
            IconButton(
              onPressed: _saveChanges,
              icon: Icon(LucideIcons.check, color: CustomColors.green),
              tooltip: 'Save',
            ),
            IconButton(
              onPressed: _cancelEdit,
              icon: Icon(LucideIcons.x, color: CustomColors.scaffoldRed),
              tooltip: 'Cancel',
            ),
          ],
        ] else ...[
          IconButton(
            onPressed: _toggleEditMode,
            icon: Icon(LucideIcons.edit, color: appColors.dynamicIconColor),
            tooltip: 'Edit',
          ),
          _buildPopupMenu(appColors),
        ],
      ],
    );
  }

  Widget _buildPopupMenu(AppThemeColors appColors) {
    return PopupMenuButton<String>(
      color: appColors.background,
      icon: Icon(LucideIcons.moreVertical, color: appColors.dynamicIconColor),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                LucideIcons.trash2,
                color: CustomColors.scaffoldRed,
                size: 18,
              ),
              Gap(CustomPadding.padding),
              Text(
                'Delete Employee',
                style: TextStyle(color: CustomColors.scaffoldRed),
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'delete') {
          _deleteEmployee();
        }
      },
    );
  }

  Widget _buildSectionTitle(AppThemeColors appColors) {
    return Padding(
      padding: EdgeInsets.only(left: CustomPadding.padding),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Employee Details',
          style: TextStyle(
            color: appColors.textContrastColor,
            fontFamily: CustomFont.intelOneMono,
            fontSize: 18.fSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsList(AppThemeColors appColors) {
    return ListView(
      key: ValueKey('details_list_${_selectedDob?.millisecondsSinceEpoch}'),
      children: [
        EmployeeDetailsWidgets.buildDetailCard(
          appColors: appColors,
          title: 'Department',
          icon: EmployeeDetailsHelpers.getCategoryIcon(_employee.category),
          value: _isEditMode
              ? _controllers['category']!.text
              : _employee.category,
          fieldKey: 'category',
          isEditMode: _isEditMode,
          controllers: _controllers,
          isDropdown: true,
        ),
        EmployeeDetailsWidgets.buildDetailCard(
          appColors: appColors,
          title: 'Role',
          icon: Icons.work,
          value: _isEditMode ? _controllers['role']!.text : _employee.role,
          fieldKey: 'role',
          isEditMode: _isEditMode,
          controllers: _controllers,
        ),
        EmployeeDetailsWidgets.buildDetailCard(
          appColors: appColors,
          title: 'Email',
          icon: Icons.email,
          value: _isEditMode ? _controllers['email']!.text : _employee.email,
          fieldKey: 'email',
          keyboardType: TextInputType.emailAddress,
          isEditMode: _isEditMode,
          controllers: _controllers,
        ),
        EmployeeDetailsWidgets.buildDetailCard(
          appColors: appColors,
          title: 'Phone Number',
          icon: Icons.phone,
          value: _isEditMode
              ? _controllers['phone']!.text
              : _employee.phoneNumber,
          fieldKey: 'phone',
          keyboardType: TextInputType.phone,
          isEditMode: _isEditMode,
          controllers: _controllers,
          onTap: !_isEditMode
              ? () => Redirect.makePhoneCall(_employee.phoneNumber)
              : null,
        ),
        EmployeeDetailsWidgets.buildDetailCard(
          appColors: appColors,
          title: 'Whatsapp Number',
          icon: LucideIcons.messageCircle,
          value: _isEditMode
              ? _controllers['whatsapp']!.text
              : _employee.whatsappNumber,
          fieldKey: 'whatsapp',
          keyboardType: TextInputType.phone,
          isEditMode: _isEditMode,
          controllers: _controllers,
          onTap: !_isEditMode
              ? () => Redirect.openWhatsApp(_employee.whatsappNumber)
              : null,
        ),

        _buildDateCard(appColors),
      ],
    );
  }

  Widget _buildDateCard(AppThemeColors appColors) {
    final currentSelectedDob = _selectedDob;
    final displayDate = _isEditMode
        ? (currentSelectedDob ?? _employee.dob)
        : _employee.dob;
    final hasDateChanged =
        currentSelectedDob != null && currentSelectedDob != _employee.dob;

    return Container(
      key: ValueKey(
        'date_card_${currentSelectedDob?.millisecondsSinceEpoch}_${_isEditMode}',
      ),
      child: Padding(
        padding: const EdgeInsets.all(CustomPadding.padding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
            color: appColors.secondaryColor,
            border: _isEditMode
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
            subtitle: _isEditMode
                ? InkWell(
                    onTap: () => _selectDate(context),
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
            trailing: _isEditMode
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
      ),
    );
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = true;
    });
  }

  void _cancelEdit() {
    _controllers['name']!.text = _employee.name;
    _controllers['email']!.text = _employee.email;
    _controllers['phone']!.text = _employee.phoneNumber;
    _controllers['whatsapp']!.text = _employee.whatsappNumber;
    _controllers['role']!.text = _employee.role;
    _controllers['category']!.text = _employee.category;

    _selectedDob = _employee.dob;

    setState(() {
      _isEditMode = false;
    });
  }

  void _saveChanges() async {
    final validationError = EmployeeDetailsHelpers.validateEmployeeData(
      _controllers,
    );
    if (validationError != null) {
      EmployeeDetailsDialogs.showErrorToast(validationError);
      return;
    }

    final dateToSave = _selectedDob!;

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedEmployee = _employee.copyWith(
        name: _controllers['name']!.text.trim(),
        email: _controllers['email']!.text.trim(),
        phoneNumber: _controllers['phone']!.text.trim(),
        whatsappNumber: _controllers['whatsapp']!.text.trim(),
        role: _controllers['role']!.text.trim(),
        category: _controllers['category']!.text.trim(),
        dob: dateToSave,
      );

      await _saveToDatabase(updatedEmployee);

      setState(() {
        _employee = updatedEmployee;
        _selectedDob = updatedEmployee.dob;
        _isEditMode = false;
        _isLoading = false;
      });

      EmployeeDetailsDialogs.showSuccessToast(
        'Employee details updated successfully',
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      EmployeeDetailsDialogs.showErrorToast(
        'Failed to update employee details: ${e.toString()}',
      );
    }
  }

  Future<void> _deleteEmployee() async {
    final confirmed = await EmployeeDetailsDialogs.showDeleteConfirmation(
      context: context,
      employee: _employee,
    );
    if (!confirmed) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _employeeService.deleteEmployee(_employee);
      EmployeeDetailsDialogs.showSuccessToast('Employee deleted successfully');
      Navigator.pop(context, 'deleted');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      EmployeeDetailsDialogs.showErrorToast(
        'Failed to delete employee: ${e.toString()}',
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await EmployeeDetailsDialogs.selectDate(
      context: context,
      initialDate: _selectedDob ?? _employee.dob,
    );

    if (picked != null && picked != _selectedDob) {
      setState(() {
        _selectedDob = picked;
      });
    }
  }

  Future<void> _saveToDatabase(Employee employee) async {
    try {
      await _employeeService.updateEmployeeData(employee);
    } catch (e) {
      throw Exception('Failed to save employee data: $e');
    }
  }
}
