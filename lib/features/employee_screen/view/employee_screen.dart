import 'package:attea/constants/constants.dart';
import 'package:attea/extensions/app_theme_extensions.dart';
import 'package:attea/features/employee_screen/services/employee_service.dart';
import 'package:attea/features/employee_screen/models/employee_model.dart';
import 'package:attea/features/employee_screen/view/add_employee_screen.dart';
import 'package:attea/widgets/common_textfield.dart';
import 'package:attea/widgets/mini_loading_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final EmployeeService _employeeService = EmployeeService();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: CustomPadding.paddingLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MiniLoadingButton(
              size: ButtonSize.large,
              // backgroundColor: CustomColors. ,
              text: 'Add Members',
              fontFamily: CustomFont.intelOneMono,
              onPressed: () {
                Navigator.pushNamed(context, AddEmployeeScreen.path);
              },
              needRow: true,
              prefixIcon: Icon(
                Icons.add_circle_outline_outlined,
                color: appColors.textContrastColor,
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      backgroundColor: appColors.background,
      appBar: AppBar(
        surfaceTintColor: appColors.background,
        backgroundColor: appColors.background,
        
        title: Text(
          'Employees',
          style: TextStyle(
            color: appColors.dynamicIconColor,
            fontFamily: CustomFont.intelOneMono,
          ),
        ),
      ),
      body: Column(
        children: [
          Gap(CustomPadding.paddingLarge),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: CustomPadding.padding),
            child: CommonTextfield(
              // controller: controller,
              prefixIcon: Icons.search,
              hintText: 'Search',
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: StreamBuilder<List<Employee>>(
              stream: _employeeService.getEmployees(searchQuery: searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No employees found.'));
                }

                final employees = snapshot.data!;

                employees.sort((a, b) {
                  final timestampA = a.timestamp ?? Timestamp.now();
                  final timestampB = b.timestamp ?? Timestamp.now();
                  return timestampB.compareTo(timestampA);
                });

                return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: appColors.background,

                        borderRadius: BorderRadius.circular(
                          CustomPadding.paddingLarge,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: CustomPadding.padding,
                        horizontal: CustomPadding.paddingLarge,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: employee.photoUrl.isNotEmpty
                              ? CachedNetworkImageProvider(employee.photoUrl)
                              : null,
                          child: employee.photoUrl.isEmpty
                              ? Icon(Icons.person)
                              : null,
                        ),
                        title: Text(
                          employee.name,
                          style: TextStyle(
                            color: appColors.textContrastColor,
                            fontSize: 20,
                            fontFamily: CustomFont.intelOneMono,
                          ),
                        ),
                        subtitle: Text(
                          employee.category,
                          style: TextStyle(color: appColors.textLightGrey),
                        ),
                        trailing: Text(
                          employee.employeeId.toUpperCase(),
                          style: TextStyle(color: appColors.textLightGrey),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          //Add Members button
          // Expanded(
          //   flex: 1,
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         MiniLoadingButton(
          //           size: ButtonSize.large,
          //           // backgroundColor: CustomColors. ,
          //           text: 'Add Members',
          //           fontFamily: CustomFont.intelOneMono,
          //           onPressed: () {
          //             Navigator.pushNamed(context, AddEmployeeScreen.path);
          //           },
          //           needRow: true,
          //           prefixIcon: Icon(
          //             Icons.add_circle_outline_outlined,
          //             // color: appColors.textContrastColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // ),
        ],
      ),
    );
  }
}
