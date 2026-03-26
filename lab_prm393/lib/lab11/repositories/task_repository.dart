import '../models/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  List<Task> getTasks() {
    return List.unmodifiable(_tasks);
  }

  Task addTask(String title) {
    if (title.trim().isEmpty) {
      throw ArgumentError('Task title cannot be empty');
    }

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );
    _tasks.add(task);
    return task;
  }

  bool deleteTask(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks.removeAt(index);
      return true;
    }
    return false;
  }

  Task? updateTask(String taskId, {String? title, bool? isCompleted}) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      final currentTask = _tasks[index];
      final updatedTask = Task(
        id: currentTask.id,
        title: title ?? currentTask.title,
        isCompleted: isCompleted ?? currentTask.isCompleted,
        createdAt: currentTask.createdAt,
      );
      _tasks[index] = updatedTask;
      return updatedTask;
    }
    return null;
  }

  Task? getTask(String taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }

  void clearAllTasks() {
    _tasks.clear();
  }
}