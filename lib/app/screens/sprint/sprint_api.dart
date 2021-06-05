import 'dart:convert';

import 'package:http/http.dart';
import 'package:scrum_poker/app/shared/models/sprint.dart';
import 'package:scrum_poker/app/shared/util/constants.dart';

class SprintApi {
  final Client _client;
  SprintApi(this._client);

  Future<List<Sprint>> fetchSprints() async {
    final response =
        await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> jSprints = json.decode(response.body);
      return jSprints.map((js) => Sprint.fromJson(js)).toList();
    } else {
      throw Exception('Erro ao tentar recuperar as sprints');
    }
  }

  Future<String> addSprint(Sprint sprint) async {
    final response = await _client.post(
        Uri.parse('${Constants.API_BASE_URL}/sprint'),
        headers: {
          'Accept': Constants.APPLICATION_JSON,
          'content-type': Constants.APPLICATION_JSON
        },
        body: sprint.toRawJsonWithoutId());

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return 'Sprint cadastrada com sucesso!';
    } else {
      throw Exception(
          'Erro ao tentar salvar a sprint. StatusCode: ${response.statusCode}');
    }
  }

  Future<String> editSprint(Sprint sprint) async {
    final response = await _client.put(
        Uri.parse('${Constants.API_BASE_URL}/sprint/${sprint.id}'),
        headers: {
          'Accept': Constants.APPLICATION_JSON,
          'content-type': Constants.APPLICATION_JSON
        },
        body: sprint.toRawJson());

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return 'Sprint alterada com sucesso!';
    } else {
      throw Exception(
          'Erro ao tentar alterar a sprint. StatusCode: ${response.statusCode}');
    }
  }

  Future<String> removeSprint(int id) async {
    final response = await _client
        .delete(Uri.parse('${Constants.API_BASE_URL}/sprint/$id'), headers: {
      'Accept': Constants.APPLICATION_JSON,
      'content-type': Constants.APPLICATION_JSON
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return 'Sprint excluída com sucesso!';
    } else {
      throw Exception(
          'Erro ao tentar excluir a sprint. StatusCode: ${response.statusCode}');
    }
  }

  Future<Sprint> findSprintById(int id) async {
    final response = await _client
        .get(Uri.parse('${Constants.API_BASE_URL}/sprint/$id'), headers: {
      'Accept': Constants.APPLICATION_JSON,
      'content-type': Constants.APPLICATION_JSON
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final dynamic jSprint = json.decode(response.body);
      return Sprint.fromJson(jSprint);
    } else {
      throw Exception(
          'Erro ao tentar excluir a sprint. StatusCode: ${response.statusCode}');
    }
  }
}
