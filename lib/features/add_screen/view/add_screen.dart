import '/features/example_pages/sample_modal_example.dart';

import '/constants/constants.dart';

import '../../example_pages/tabbar_example.dart';
import '/widgets/mini_loading_button.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MiniLoadingButton(
                    text: 'View sample modal ',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SampleModalExample(),
                      ));
                    },
                  ),
                  CustomGap.gapLarge,
                  MiniLoadingButton(
                    text: 'View Tabbar',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SampleTabPage(),
                      ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
