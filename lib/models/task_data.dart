import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:todoey_app_flutter/models/task.dart';

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
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
