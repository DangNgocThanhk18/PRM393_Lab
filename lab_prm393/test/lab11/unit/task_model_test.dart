import 'package:flutter_test/flutter_test.dart';
import '../../../lib/lab11/models/task.dart';

void main() {
  group('Task Model Tests', () {
    late Task task;

    setUp(() {
      task = Task(
        id: '1',
        title: 'Test Task',
      );
    });

    test('Default completed value should be false', () {
      expect(task.isCompleted, false);
    });

    test('toggle() should change isCompleted from false to true', () {
      expect(task.isCompleted, false);

      final toggledTask = task.toggle();

      expect(toggledTask.isCompleted, true);
      expect(toggledTask.id, task.id);
      expect(toggledTask.title, task.title);
    });

    test('toggle() should change isCompleted from true to false', () {
      final completedTask = Task(
        id: '2',
        title: 'Completed Task',
        isCompleted: true,
      );
      expect(completedTask.isCompleted, true);

      final toggledTask = completedTask.toggle();

      expect(toggledTask.isCompleted, false);
    });

    test('toggle() should not modify other properties', () {
      final originalTask = Task(
        id: '3',
        title: 'Original Title',
        isCompleted: false,
        createdAt: DateTime(2024, 1, 1),
      );

      final toggledTask = originalTask.toggle();

      expect(toggledTask.id, originalTask.id);
      expect(toggledTask.title, originalTask.title);
      expect(toggledTask.createdAt, originalTask.createdAt);
    });

    test('copyWith() should create new instance with modified values', () {
      final originalTask = Task(
        id: '4',
        title: 'Original',
        isCompleted: false,
      );

      final updatedTask = originalTask.copyWith(
        title: 'Updated',
        isCompleted: true,
      );

      expect(updatedTask.id, originalTask.id);
      expect(updatedTask.title, 'Updated');
      expect(updatedTask.isCompleted, true);
      expect(originalTask.title, 'Original');
    });
  });
}