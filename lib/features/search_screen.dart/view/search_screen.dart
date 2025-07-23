

import '/constants/constants.dart';
import '/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(CustomPadding.paddingXXL),
          CommonTextfield(
            controller: controller,
            prefixIcon: Icons.search,
            hintText: 'Search',
          ),
          Gap(CustomPadding.paddingXXL),
        
        ],
      ),
    );
  }
}

