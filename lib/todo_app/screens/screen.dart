import 'package:todo/todo_app/screens/dialogue_helper.dart';
import 'package:flutter/material.dart';
import 'package:todo/api_service.dart';
import 'package:todo/functionality.dart';
import 'package:todo/model.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<Model> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    setState(() {
      _isLoading = true;
    });
    final tasks = await ApiService.getTodos();
    setState(() {
      _tasks = tasks;
      _isLoading = false;
    });
  }
    void _showAddTaskDialog() {
    DialogHelper.showTaskDialog(
      context: context,
      title: 'Add New Task',
      taskTitle: '',
      taskSubtitle: '',
      onSubmit: (title, subtitle) {
        Functionality.addTask(context, _tasks, title, subtitle, _fetchTasks);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF50C2C9),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/todo1.png'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to ToDo App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Daily Tasks",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: _showAddTaskDialog,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Color(0xFF50C2C9),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: _tasks.length,
                              itemBuilder: (context, index) {
                                final task = _tasks[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 20),
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            const Color(0xFF50C2C9),
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        task.todo,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration: task.isCompleted
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                      subtitle: Text(
                                        task.description,
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: task.isCompleted
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                      trailing: Checkbox(
                                        value: task.isCompleted,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            task.isCompleted = value ?? false;
                                          });
                                        },
                                        checkColor: Colors.white,
                                        activeColor: const Color(0xFF50C2C9),
                                      ),
                                      onLongPress: () {
                                        DialogHelper.showEditDeleteDialog(
                                          context: context,
                                          onEdit: () {
                                            DialogHelper.showTaskDialog(
                                              context: context,
                                              title: 'Edit Task',
                                              taskTitle: task.todo,
                                              taskSubtitle: task.description,
                                              onSubmit: (title, subtitle) {
                                                task.todo = title;
                                                task.description = subtitle;
                                                Functionality.updateTask(context, task, _fetchTasks);
                                              },
                                            );
                                          },
                                          onDelete: () {
                                          Functionality.deleteTask(context, task, _fetchTasks);
                                          },
                                        );
                                      },
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      height: 1,
                                      thickness: 1,
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
