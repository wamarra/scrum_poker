import 'package:flutter/material.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_bloc.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_module.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';

class SprintAddWidget extends StatefulWidget {
  @override
  _SprintAddState createState() => _SprintAddState();
}

class _SprintAddState extends State<SprintAddWidget> {
  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _link = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Sprint',
          style: TextStyle(color: Colors.tealAccent),
        ),
        iconTheme: IconThemeData(
          color: Colors.tealAccent, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  _nome = value;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Link é obrigatório';
                  }
                  _link = value;
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _bloc.doAdd(Sprint(nome: _nome, link: _link));
                      return Navigator.pop(context);
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
