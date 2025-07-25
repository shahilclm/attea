import 'package:attea/constants/constants.dart';
import 'package:attea/extensions/app_theme_extensions.dart';
import 'package:attea/features/employee_screen/services/employee_service.dart';
import 'package:attea/features/employee_screen/models/employee_model.dart';
import 'package:attea/features/employee_screen/view/add_employee_screen.dart';
import 'package:attea/features/employee_screen/view/employee_details_screen.dart';
import 'package:attea/widgets/common_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen>
    with SingleTickerProviderStateMixin {
  final EmployeeService _employeeService = EmployeeService();
  String searchQuery = '';

  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _widthAnimation = Tween<double>(
      begin: 56.0,
      end: 180.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onFabTap() {
    Navigator.pushNamed(context, AddEmployeeScreen.path);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      extendBody: true,
      backgroundColor: appColors.background,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,

      floatingActionButton: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: _onFabTap,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: _widthAnimation.value,
              height: 56,
              decoration: BoxDecoration(
                color: appColors.primary,
                borderRadius: BorderRadius.circular(28),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: appColors.dynamicIconColor),
                  if (_widthAnimation.value > 100) ...[
                    SizedBox(width: 8),
                    AnimatedOpacity(
                      opacity: _widthAnimation.value > 130 ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Text(
                        "Add Members",
                        style: TextStyle(
                          color: appColors.dynamicIconColor,
                          fontFamily: CustomFont.intelOneMono,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),

      // floatingActionButton: AnimatedBuilder(
      //   animation: _controller,
      //   builder: (context, child) {
      //     return Container(
      //       width: _widthAnimation.value,
      //       height: 56,
      //       child: FloatingActionButton.extended(
      //         onPressed: _onFabTap,
      //         backgroundColor: appColors.primary,
      //         foregroundColor: appColors.background,
      //         icon: Icon(Icons.add),
      //         label: _widthAnimation.value > 100
      //             ? Text(
      //                 "Add Members",
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.w600,
      //                   fontFamily: CustomFont.intelOneMono,
      //                 ),
      //               )
      //             : SizedBox.shrink(),
      //         isExtended: true,
      //       ),
      //     );
      //   },
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Gap(CustomPadding.paddingLarge),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: CustomPadding.padding),
              child: CommonTextfield(
                fillColor: appColors.background.withValues(alpha: 0.5),
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
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              EmployeeDetailsScreen.path,
                              arguments: employee,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
