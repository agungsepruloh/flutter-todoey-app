import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoey_app_flutter/screens/tasks_screen.dart';
import 'package:todoey_app_flutter/models/task_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // all the childrens of the widget will listen the data
    return ChangeNotifierProvider(
      builder: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
