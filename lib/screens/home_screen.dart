import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_waizly_mobile/models/todo.dart';
import 'package:technical_test_waizly_mobile/providers/todo_provider.dart';
import 'package:technical_test_waizly_mobile/screens/edit_todo_screen.dart';
import 'package:technical_test_waizly_mobile/widgets/todo_item.dart';
import 'package:technical_test_waizly_mobile/screens/add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, _) {
          List<Todo> todoList = todoProvider.todos;
          return ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final todo = todoList[index];
              return TodoItem(
                todo: todo,
                onCheckboxChanged: (value) {
                  todoProvider.toggleTodoComplete(index);
                },
                onEditPressed: () {
                  _navigateToEditScreen(context, index, todo);
                },
                onDeletePressed: () {
                  todoProvider.deleteTodo(index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context, int index, Todo todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditTodoScreen(index: index, todo: todo)),
    );
  }
}
