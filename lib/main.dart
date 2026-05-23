import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_fifteen/todo_list_provider.dart';
import 'package:ostad_flutter_batch_fifteen/todo_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => TodoListProvider()),
      ],
      child: const MaterialApp(
        home: TodoScreen(),
      ),
    );
  }
}
