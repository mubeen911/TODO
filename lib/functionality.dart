import 'package:flutter/material.dart';
import 'package:todo/api_service.dart';
import 'package:todo/model.dart';

class Functionality {
  static Future<void> addTask(
    BuildContext context,
    List<Model> tasks,
    String title,
    String subtitle,
    Function fetchTasksCallback,
  ) async {
    final newTask = Model(
      todoId: '',
      todo: title,
      description: subtitle,
      isCompleted: false,
      createdAt: '',
      updatedAt: '',
    );

    final success = await ApiService.createTodo(newTask);
    if (success) {
      fetchTasksCallback();
    } else {
      if (context.mounted) {
        _showError(context, 'Failed to create task.');
      }
    }
  }

  static Future<void> updateTask(
    BuildContext context,
    Model task,
    Function fetchTasksCallback,
  ) async {
    final updatedTask = Model(
      todoId: task.todoId,
      todo: task.todo,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: '',
      updatedAt: '',
    );

    final success = await ApiService.updateTodo(updatedTask);
    if (success) {
      fetchTasksCallback();
    } else {
      if (context.mounted) {
        _showError(context, 'Failed to update task.');
      }
    }
  }

  static Future<void> deleteTask(
    BuildContext context,
    Model task,
    Function fetchTasksCallback,
  ) async {
    final deleteTask = Model(
      todoId: task.todoId,
      todo: task.todo,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: '',
      updatedAt: '',
    );

    final success = await ApiService.deleteTodo(deleteTask);
    if (success) {
      fetchTasksCallback();
    } else {
      if (context.mounted) {
        _showError(context, 'Failed to delete task.');
      }
    }
  }

  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
