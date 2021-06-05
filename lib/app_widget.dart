import 'package:flutter/material.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_add_widget.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_list_widget.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_module.dart';

var routes = <String, WidgetBuilder>{
  "/sprintAdd": (BuildContext context) => SprintAddWidget(),
  "/sprintList": (BuildContext context) => SprintListWidget(),
};

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SprintModule(),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
