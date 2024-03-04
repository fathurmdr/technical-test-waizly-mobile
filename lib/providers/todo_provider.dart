import 'package:flutter/foundation.dart';
import 'package:technical_test_waizly_mobile/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void editTodo(int index, Todo editedTodo) {
    _todos[index] = editedTodo;
    notifyListeners();
  }

  void toggleTodoComplete(int index) {
    _todos[index].completed = !_todos[index].completed;
    notifyListeners();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
