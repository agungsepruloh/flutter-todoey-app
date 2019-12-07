import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:todoey_app_flutter/models/task.dart';
import 'package:todoey_app_flutter/helpers/db_helper.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  // getter for private variable
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();

    DBHelper.insert('user_todos', {
      'id': DateTime.now().toString(),
      'name': newTaskTitle,
      'is_done': false,
    });
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  Future<void> fetchAndSetPlace() async {
    final dataList = await DBHelper.getData('user_todos');
    _tasks = dataList
        .map(
          (item) => Task(
            name: item['name'],
            isDone: item['is_done'] == 0 ? false : true,
          ),
        )
        .toList();
    notifyListeners();
  }
}
