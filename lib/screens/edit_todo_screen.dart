import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:technical_test_waizly_mobile/models/todo.dart';
import 'package:technical_test_waizly_mobile/providers/todo_provider.dart';

class EditTodoScreen extends StatefulWidget {
  final int index;
  final Todo todo;

  EditTodoScreen({
    required this.index,
    required this.todo,
  });

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _deadlineController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
    _deadlineController = TextEditingController(
        text: DateFormat('yyyy-MM-dd HH:mm').format(widget.todo.deadline));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _deadlineController,
              decoration: InputDecoration(labelText: 'Deadline'),
              readOnly: true,
              onTap: _selectDateTime,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _editTodo(context);
              },
              child: Text('Update Todo'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDateTime() async {
    var _deadline =
        DateTime.tryParse(_deadlineController.text) ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_deadline),
      );
      if (pickedTime != null) {
        _deadline = DateTime(picked.year, picked.month, picked.day,
            pickedTime.hour, pickedTime.minute);
        _deadlineController.text =
            DateFormat('yyyy-MM-dd HH:mm').format(_deadline);
      }
    }
  }

  void _editTodo(BuildContext context) {
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();
    final String deadlineString = _deadlineController.text.trim();
    final DateTime deadline =
        DateTime.parse(deadlineString); // Parse string ke dalam DateTime

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        deadlineString.isNotEmpty) {
      final Todo editedTodo = Todo(
          title: title,
          description: description,
          deadline: deadline,
          completed: widget.todo.completed);

      Provider.of<TodoProvider>(context, listen: false)
          .editTodo(widget.index, editedTodo);

      Navigator.pop(context);
    } else {
      // Tampilkan pesan kesalahan jika field tidak diisi
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
