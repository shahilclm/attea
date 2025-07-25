import 'package:attea/exporter/exporter.dart';
import 'package:attea/features/landing_screen/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Logout',
          style: TextStyle(fontFamily: CustomFont.intelOneMono),
        ),
        content: Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),

          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, LandingPage.path);
            },
            child: Text('Logout'),
          ),
        ],
      );
    },
  );
}
