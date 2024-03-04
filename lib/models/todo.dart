class Todo {
  final String title;
  final String description;
  final DateTime deadline;
  bool completed;

  Todo({
    required this.title,
    required this.description,
    required this.deadline,
    this.completed = false,
  });
}
