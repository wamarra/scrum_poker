import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:scrum_poker/app/screens/sprint/sprint_api.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';

class SprintBloc extends BlocBase {
  final SprintApi _api;
  SprintBloc(this._api);

  late final _sprintFetcher = PublishSubject<List<Sprint>>();
  late final _sprintAdded = PublishSubject<String>();
  late final _sprintEdited = PublishSubject<String>();
  late final _sprintRemoved = PublishSubject<String>();
  late final _sprintFindById = PublishSubject<Sprint>();
  late final _loading = BehaviorSubject<bool>();

  Stream<List<Sprint>> get sprints => _sprintFetcher.stream;
  Stream<String> get addResult => _sprintAdded.stream;
  Stream<String> get editResult => _sprintEdited.stream;
  Stream<String> get removeResult => _sprintRemoved.stream;
  Stream<Sprint> get sprint => _sprintFindById.stream;
  Stream<bool> get loading => _loading.stream;

  doFetch() async {
    _loading.sink.add(true);

    final sprints = await _api.fetchSprints();
    _sprintFetcher.sink.add(sprints);

    _loading.sink.add(false);
  }

  doAdd(sprint) async {
    _loading.sink.add(true);

    final addResult = await _api.addSprint(sprint);
    _sprintAdded.sink.add(addResult);

    await doFetch();
  }

  doEdit(sprint) async {
    _loading.sink.add(true);

    final editResult = await _api.editSprint(sprint);
    _sprintEdited.sink.add(editResult);

    await doFetch();
  }

  doRemove(id) async {
    _loading.sink.add(true);

    final removeResult = await _api.removeSprint(id);
    _sprintRemoved.sink.add(removeResult);

    await doFetch();
  }

  doFindById(id) async {
    _loading.sink.add(true);

    final sprint = await _api.findSprintById(id);
    _sprintFindById.sink.add(sprint);

    _loading.sink.add(false);
  }

  @override
  void dispose() {
    _sprintFetcher.close();
    _sprintAdded.close();
    _sprintEdited.close();
    _sprintRemoved.close();
    _sprintFindById.close();
    _loading.close();
    super.dispose();
  }
}
