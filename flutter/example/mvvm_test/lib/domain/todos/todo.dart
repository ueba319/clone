class Todo {
  const Todo({required this.id, required this.title, this.isCompleted = false});

  final String id;
  final String title;
  final bool isCompleted;
}
