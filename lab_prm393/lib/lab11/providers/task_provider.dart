import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

final taskRepositoryProvider = Provider((ref) => TaskRepository());

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
      (ref) => TaskListNotifier(ref.read(taskRepositoryProvider)),
);

class TaskListNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;

  TaskListNotifier(this._repository) : super(_repository.getTasks());

  void addTask(String title) {
    _repository.addTask(title);
    state = _repository.getTasks();
  }

  void deleteTask(String taskId) {
    _repository.deleteTask(taskId);
    state = _repository.getTasks();
  }

  void updateTask(String taskId, {String? title, bool? isCompleted}) {
    _repository.updateTask(taskId, title: title, isCompleted: isCompleted);
    state = _repository.getTasks();
  }

  void toggleTask(String taskId) {
    final task = _repository.getTask(taskId);
    if (task != null) {
      _repository.updateTask(taskId, isCompleted: !task.isCompleted);
      state = _repository.getTasks();
    }
  }

  void refresh() {
    state = _repository.getTasks();
  }
}