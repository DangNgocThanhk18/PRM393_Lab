import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/lab11/screens/task_list_screen.dart';
import '../test_helpers.dart';

void main() {
  group('TaskListScreen Widget Tests', () {
    testWidgets('should show empty state when no tasks exist', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));
      await tester.pump();

      expect(find.text('No tasks yet. Add one!'), findsOneWidget);
      expect(find.byKey(const Key('emptyStateText')), findsOneWidget);
    });

    testWidgets('should add a task when user enters text and taps add button', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));

      const taskTitle = 'Buy groceries';

      await tester.enterText(find.byKey(const Key('taskInput')), taskTitle);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      expect(find.text(taskTitle), findsOneWidget);
      expect(find.text('No tasks yet. Add one!'), findsNothing);
    });

    testWidgets('should display multiple tasks when added', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));

      const task1 = 'Task 1';
      const task2 = 'Task 2';

      await tester.enterText(find.byKey(const Key('taskInput')), task1);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      await tester.enterText(find.byKey(const Key('taskInput')), task2);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      expect(find.text(task1), findsOneWidget);
      expect(find.text(task2), findsOneWidget);
      expect(find.text('No tasks yet. Add one!'), findsNothing);
    });

    testWidgets('should clear input field after adding task', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));

      const taskTitle = 'Test Task';

      await tester.enterText(find.byKey(const Key('taskInput')), taskTitle);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      final inputField = find.byKey(const Key('taskInput'));
      expect((tester.widget<TextField>(inputField).controller?.text), isEmpty);
    });
  });
}