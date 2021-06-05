import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:scrum_poker/app_bloc.dart';
import 'package:scrum_poker/app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [Bloc((inject) => AppBloc())];

  @override
  List<Dependency> get dependencies => [
        Dependency((inject) => RetryClient(Client())),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
