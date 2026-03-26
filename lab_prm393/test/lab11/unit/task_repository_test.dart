import 'package:flutter_test/flutter_test.dart';
import '../../../lib/lab11/repositories/task_repository.dart';

void main() {
  group('TaskRepository Tests', () {
    late TaskRepository repository;

    setUp(() {
      repository = TaskRepository();
    });

    tearDown(() {
      repository.clearAllTasks();
    });

    group('addTask()', () {
      test('should add task with valid title', () {
        const title = 'New Task';

        final task = repository.addTask(title);

        expect(task.title, title);
        expect(task.isCompleted, false);
        expect(task.id, isNotEmpty);
        expect(repository.getTasks().length, 1);
      });

      test('should throw error when adding empty title', () {
        const emptyTitle = '';

        expect(() => repository.addTask(emptyTitle), throwsArgumentError);
        expect(repository.getTasks().isEmpty, true);
      });

      test('should trim whitespace from title', () {
        const titleWithSpaces = '  New Task  ';

        final task = repository.addTask(titleWithSpaces);

        expect(task.title, 'New Task');
      });
    });

    group('deleteTask()', () {
      test('should delete existing task', () {
        final task = repository.addTask('Task to delete');
        expect(repository.getTasks().length, 1);

        final result = repository.deleteTask(task.id);

        expect(result, true);
        expect(repository.getTasks().isEmpty, true);
      });

      test('should return false when deleting non-existent task', () {
        repository.addTask('Existing Task');

        final result = repository.deleteTask('non-existent-id');

        expect(result, false);
        expect(repository.getTasks().length, 1);
      });
    });

    group('updateTask()', () {
      test('should update task title', () {
        final task = repository.addTask('Original Title');

        final updatedTask = repository.updateTask(task.id, title: 'Updated Title');

        expect(updatedTask, isNotNull);
        expect(updatedTask!.title, 'Updated Title');
        expect(updatedTask.id, task.id);
        expect(repository.getTasks().first.title, 'Updated Title');
      });

      test('should update task completion status', () {
        final task = repository.addTask('Task');
        expect(task.isCompleted, false);

        final updatedTask = repository.updateTask(task.id, isCompleted: true);

        expect(updatedTask, isNotNull);
        expect(updatedTask!.isCompleted, true);
      });

      test('should return null when updating non-existent task', () {
        final result = repository.updateTask('non-existent-id', title: 'New Title');

        expect(result, null);
      });
    });
  });
}