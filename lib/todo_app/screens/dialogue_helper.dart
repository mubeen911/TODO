import 'package:flutter/material.dart';

class DialogHelper {
  static void showTaskDialog({
    required BuildContext context,
    required String title,
    required String taskTitle,
    required String taskSubtitle,
    required Function(String, String) onSubmit,
  }) {
    final TextEditingController titleController =
        TextEditingController(text: taskTitle);
    final TextEditingController subtitleController =
        TextEditingController(text: taskSubtitle);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(labelText: 'Task Subtitle'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    subtitleController.text.isNotEmpty) {
                  onSubmit(titleController.text, subtitleController.text);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in both fields')),
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF50C2C9),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showEditDeleteDialog({
    required BuildContext context,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Edit'),
                onTap: () {
                  Navigator.of(context).pop();
                  onEdit();
                },
              ),
              ListTile(
                title: const Text('Delete'),
                onTap: () {
                  Navigator.of(context).pop();
                  onDelete();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
