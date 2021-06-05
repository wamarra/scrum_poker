import 'package:flutter/material.dart';

class AppNavigator {
  static void goToSprintAdd(BuildContext context) {
    Navigator.pushNamed(context, "/sprintAdd");
  }

  static void goToSprintList(BuildContext context) {
    Navigator.pushNamed(context, "/sprintList");
  }
}
