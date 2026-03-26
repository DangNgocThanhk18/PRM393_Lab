import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

/// Provider cho repository
final taskRepositoryProvider = Provider((ref) => TaskRepository());

/// Provider cho danh sách tasks với StateNotifier
final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
      (ref) => TaskListNotifier(ref.read(taskRepositoryProvider)),
);

/// StateNotifier quản lý state của danh sách tasks
class TaskListNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;

  TaskListNotifier(this._repository) : super(_repository.getTasks());

  /// Thêm task mới
  void addTask(String title) {
    _repository.addTask(title);
    state = _repository.getTasks();
  }

  /// Xóa task
  void deleteTask(String taskId) {
    _repository.deleteTask(taskId);
    state = _repository.getTasks();
  }

  /// Cập nhật task
  void updateTask(String taskId, {String? title, bool? isCompleted}) {
    _repository.updateTask(taskId, title: title, isCompleted: isCompleted);
    state = _repository.getTasks();
  }

  /// Đảo trạng thái completed của task
  void toggleTask(String taskId) {
    final task = _repository.getTask(taskId);
    if (task != null) {
      _repository.updateTask(taskId, isCompleted: !task.isCompleted);
      state = _repository.getTasks();
    }
  }

  /// Refresh danh sách
  void refresh() {
    state = _repository.getTasks();
  }
}