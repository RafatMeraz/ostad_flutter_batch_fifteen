import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_fifteen/add_todo_screen.dart';
import 'package:ostad_flutter_batch_fifteen/todo_list_provider.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: Consumer<TodoListProvider>(
        builder: (context, todoListProvider, _) {
          return ListView.builder(
            itemCount: todoListProvider.todoList.length,
            itemBuilder: (context, index) {
              final todo = todoListProvider.todoList[index];

              return ListTile(
                title: Text(todo.title),
                subtitle: Text('Created At: ${todo.createdAt}'),
                trailing: IconButton(
                  onPressed: () {
                    context.read<TodoListProvider>().deleteTodo(todo.id);
                  },
                  icon: Icon(Icons.delete_forever_rounded),
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTodo,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTodo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodoScreen()),
    );
  }
}
