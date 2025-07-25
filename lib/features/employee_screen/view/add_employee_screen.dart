import 'dart:io';

import 'package:attea/exporter/exporter.dart';
import 'package:attea/features/employee_screen/models/employee_model.dart';
import 'package:attea/features/employee_screen/services/employee_service.dart';
import 'package:attea/widgets/common_textfield.dart';
import 'package:attea/widgets/custom_dropdown_field.dart';
import 'package:attea/widgets/mini_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddEmployeeScreen extends StatefulWidget {
  static const String path = 'addEmployee';
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String selectedCategory = '';
  final List<String> categories = [
    'Flutter',
    'Backend',
    'Web',
    'Digital Marketing',
    'Interns',
    'Testers',
  ];
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String fullPhoneNumber = '';
  String fullWhatsappNumber = '';
  DateTime? selectedDob;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final EmployeeService employeeService = EmployeeService();
  Future<void> saveEmployees() async {
    if (_isLoading) return; // Prevent double click

    // Validate all fields
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        whatsappController.text.trim().isEmpty ||
        selectedCategory.isEmpty ||
        employeeIdController.text.trim().isEmpty ||
        roleController.text.trim().isEmpty ||
        selectedDob == null ||
        _image == null) {
      Fluttertoast.showToast(
        msg: "All fields are required, including image",
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    setState(() {
      _isLoading = true; // Set loading state
    });

    try {
      String imageUrl = '';
      if (_image != null) {
        logSuccess('Uploading image...');
        imageUrl = await employeeService.uploadImageToFirebase(_image!);
        logSuccess('Image uploaded: $imageUrl');
      }

      final employee = Employee(
        employeeId: employeeIdController.text.trim(),
        name: nameController.text.trim(),
        phoneNumber: fullPhoneNumber,
        whatsappNumber: fullWhatsappNumber,
        role: roleController.text.trim(),
        email: emailController.text.trim(),
        photoUrl: imageUrl,
        category: selectedCategory,
        dob: selectedDob!,
        
      );

      await employeeService.saveEmployeeData(employee);
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Employee added successfully!',
          backgroundColor: CustomColors.green,
          gravity: ToastGravity.TOP,
        );
        Navigator.pop(context); // Navigate back after success
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error saving employee data: $e',
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false; // Reset loading state
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: currentDate,
    );
    if (picked != null && picked != selectedDob) {
      setState(() {
        selectedDob = picked;
        dobController.text = DateFormat(' dd-MM-yyyy').format(selectedDob!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: CustomColors.lightDarkColor,
        backgroundColor: CustomColors.lightDarkColor,
        title: Text(
          'Add Members',
          style: TextStyle(
            color: CustomColors.textColorLight,
            fontFamily: CustomFont.intelOneMono,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: CustomColors.textColorLight),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomPadding.paddingXL,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.darkBackgroundColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: CustomPadding.paddingLarge * 1.5,
                    children: [
                      Gap(CustomPadding.paddingLarge),

                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : null,
                        child: _image == null
                            ? IconButton(
                                icon: Icon(LucideIcons.imagePlus),
                                color: CustomColors.kDarkDividerColor,
                                onPressed: _pickImage,
                              )
                            : Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    right: -13,
                                    child: IconButton(
                                      icon: Icon(
                                        LucideIcons.edit,
                                        color: CustomColors.textColorLight,
                                        size: 20,
                                      ),
                                      onPressed:
                                          _pickImage, // Reselect image on tap
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      CommonTextfield(
                        controller: nameController,
                        hintText: 'Enter Full Name',
                      ),
                      CommonTextfield(
                        controller: emailController,
                        hintText: 'Enter Email',
                      ),
                      IntlPhoneField(
                        disableLengthCheck: true,
                        controller: phoneController,

                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            fontFamily: CustomFont.intelOneMono,
                          ),

                          border: OutlineInputBorder(),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          setState(() {
                            fullPhoneNumber = phone.completeNumber;
                          });
                        },
                      ),
                      IntlPhoneField(
                        disableLengthCheck: true,
                        controller: whatsappController,
                        decoration: InputDecoration(
                          hintText: 'Whatsapp Number',
                          hintStyle: TextStyle(
                            fontFamily: CustomFont.intelOneMono,
                          ),

                          border: OutlineInputBorder(),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          setState(() {
                            fullWhatsappNumber = phone.completeNumber;
                          });
                        },
                      ),
                      CustomDropdownField<String>(
                        label: '',
                        hintText: ' Select Department',
                        value: selectedCategory.isEmpty
                            ? null
                            : selectedCategory,
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newCategory) {
                          setState(() {
                            selectedCategory = newCategory ?? '';
                          });
                        },
                      ),
                      CommonTextfield(
                        controller: employeeIdController,
                        hintText: 'Enter Employee Id',
                      ),
                      CommonTextfield(
                        controller: roleController,
                        hintText: 'Enter Role',
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: CommonTextfield(
                            controller: dobController,
                            hintText: 'Select Date of Birth',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: CustomColors.darkBackgroundColor,
        height: 120,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CustomPadding.paddingXXL,
            vertical: CustomPadding.paddingXL,
          ),
          child: MiniLoadingButton(
            text: 'ADD',
            onPressed: () {
              _isLoading ? null : saveEmployees();
            },
            isLoading: _isLoading,
            backgroundColor: CustomColors.lightDarkColor,
          ),
        ),
      ),
    );
  }
}
