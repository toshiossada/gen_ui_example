class TaskItemData {
  final String text;
  final bool isDone;

  const TaskItemData({required this.text, required this.isDone});

  TaskItemData copyWith({String? text, bool? isDone}) {
    return TaskItemData(
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    );
  }
}
