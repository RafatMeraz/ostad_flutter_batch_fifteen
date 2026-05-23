import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_fifteen/todo.dart';
import 'package:ostad_flutter_batch_fifteen/todo_list_provider.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _titleTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            TextFormField(
              controller: _titleTEController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            FilledButton(onPressed: _onTapAddTodo, child: Text('Add')),
          ],
        ),
      ),
    );
  }

  void _onTapAddTodo() {
    final title = _titleTEController.text.trim();
    Todo newTodo = Todo(
      id: DateTime.now().microsecondsSinceEpoch,
      title: title,
      status: 'Pending',
      createdAt: DateTime.now(),
    );
    context.read<TodoListProvider>().addTodo(newTodo);
    _titleTEController.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Added new todo!')));
  }
}
