import 'package:flutter/foundation.dart';
import 'package:ostad_flutter_batch_fifteen/todo.dart';

class TodoListProvider extends ChangeNotifier {
  final List<Todo> _todoList = [];

  List<Todo> get todoList => _todoList;

  void addTodo(Todo newTodo) {
    _todoList.add(newTodo);
    notifyListeners();
  }

  void deleteTodo(int todoId) {
    _todoList.removeWhere((todo) => todo.id == todoId);
    notifyListeners();
  }
}