import 'package:flutter/material.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_add_widget.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_bloc.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_edit_widget.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_module.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';
import 'package:scrum_poker/app/shared/util/app_navigator.dart';

class SprintListWidget extends StatelessWidget {
  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();

  @override
  Widget build(BuildContext context) {
    _bloc.doFetch();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sprints',
          style: TextStyle(color: Colors.tealAccent),
        ),
      ),
      body: StreamBuilder(
        stream: _bloc.sprints,
        builder: (_, AsyncSnapshot<List<Sprint>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (_, index) {
                  final sprint = snapshot.data![index];
                  return ListTile(
                    title: Text(sprint.nome),
                    subtitle: Text(sprint.link),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text('Editar'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('Excluir'),
                          )
                        ];
                      },
                      onSelected: (String value) {
                        actionPopUpItemSelected(value, sprint.id, context);
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => Divider(),
                itemCount: snapshot.data!.length);
          }
          return StreamBuilder(
            stream: _bloc.loading,
            builder: (_, AsyncSnapshot<bool> snapshot) {
              final loading = snapshot.data ?? false;
              if (loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppNavigator.goToSprintAdd(context),
        tooltip: 'Add Sprint',
        child: Icon(Icons.add),
      ), //
    );
  }

  Future<void> actionPopUpItemSelected(
      String value, int? id, BuildContext context) async {
    if (value == 'edit') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SprintEditWidget(id: id),
        ),
      );
    } else {
      await _bloc.doRemove(id);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sprint excluída com sucesso!')));
    }
  }
}
