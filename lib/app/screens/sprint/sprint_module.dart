import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_list_widget.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_api.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_bloc.dart';
import 'package:scrum_poker/app_module.dart';

class SprintModule extends ModuleWidget {
  @override
  List<Bloc> get blocs =>
      [Bloc((inject) => SprintBloc(inject.get<SprintApi>()))];

  @override
  List<Dependency> get dependencies =>
      [Dependency((inject) => SprintApi(AppModule.to.getDependency<Client>()))];

  @override
  Widget get view => SprintListWidget();

  static Inject get to => Inject<SprintModule>.of();
}
