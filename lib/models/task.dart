class Task {
  final String id;
  final String name;
  bool isDone;

  Task({
    this.id,
    this.name,
    this.isDone = false,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
