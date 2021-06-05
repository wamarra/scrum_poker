import 'package:flutter/material.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_bloc.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_module.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';

class SprintEditWidget extends StatefulWidget {
  final int? id;

  SprintEditWidget({Key? key, this.id}) : super(key: key);

  @override
  _SprintEditState createState() => _SprintEditState();
}

class _SprintEditState extends State<SprintEditWidget> {
  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();
  final _formKey = GlobalKey<FormState>();
  int? _id;
  String _nome = '';
  String _link = '';

  @override
  Widget build(BuildContext context) {
    _bloc.doFindById(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alterar Sprint',
          style: TextStyle(color: Colors.tealAccent),
        ),
        iconTheme: IconThemeData(
          color: Colors.tealAccent, //change your color here
        ),
      ),
      body: StreamBuilder(
        stream: _bloc.sprint,
        builder: (_, AsyncSnapshot<Sprint> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.id != null) {
              _id = snapshot.data?.id;
            }

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: snapshot.data!.nome,
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
                      initialValue: snapshot.data!.link,
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
                            _bloc.doEdit(
                                Sprint(id: _id, nome: _nome, link: _link));
                            return Navigator.pop(context);
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
