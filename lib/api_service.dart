import 'dart:convert';
import 'dart:developer' show log;
import 'package:http/http.dart' as http;
import 'package:todo/api_routes.dart';
import 'package:todo/model.dart';

class ApiService {
  static Future<bool> createTodo(Model model) async {
    const url = ApiRoutes.todoCreate;
    final Map<String, dynamic> data = {
      "todo": model.todo,
      "description": model.description,
      "isCompleted": model.isCompleted,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        log('Task created successfully');
        return true;
      } else {
        log('Failed to create task: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error creating task: $e');
      return false;
    }
  }

  static Future<List<Model>> getTodos() async {
    const url = ApiRoutes.todoGet;

    try {
      final response = await http.get(Uri.parse(url));

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        log('Parsed Data: $data');

        List<Model> tasks = data.map((json) => Model.fromJson(json)).toList();
        return tasks;
      } else {
        log('Failed to load tasks: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching tasks: $e');
      return [];
    }
  }

  static Future<bool> updateTodo(Model model) async {
    const url = ApiRoutes.todoUpdate;
    final Map<String, dynamic> updates = {
      "todo": model.todo,
      "description": model.description,
      "isCompleted": model.isCompleted,
      'todoId': model.todoId
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updates),
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        log('Task updated successfully');
        return true;
      } else {
        log('Failed to create task: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error creating task: $e');
      return false;
    }
  }

  static Future<bool> deleteTodo(Model model) async {
    final url = '${ApiRoutes.todoDelete}/${model.todoId}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        log('Task deleted successfully');
        return true;
      } else {
        log('Failed to delete task: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error deleting task: $e');
      return false;
    }
  }
}
