import 'package:flutter/foundation.dart';
import '../models/task.dart';

/// Repository quản lý danh sách tasks
class TaskRepository {
  final List<Task> _tasks = [];

  /// Lấy danh sách tasks
  List<Task> getTasks() {
    return List.unmodifiable(_tasks);
  }

  /// Thêm task mới
  Task addTask(String title) {
    if (title.trim().isEmpty) {
      throw ArgumentError('Task title cannot be empty');
    }

    // Chỉ in log khi ở debug mode
    if (kDebugMode) {
      print('Adding task: $title');
    }

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );
    _tasks.add(task);
    return task;
  }

  /// Xóa task theo id
  bool deleteTask(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks.removeAt(index);
      return true;
    }
    return false;
  }

  /// Cập nhật task
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

  /// Lấy task theo id
  Task? getTask(String taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }

  /// Xóa tất cả tasks (dùng cho test)
  void clearAllTasks() {
    _tasks.clear();
  }
}