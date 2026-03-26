import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/lab11/screens/task_list_screen.dart';
import '../test_helpers.dart';

void main() {
  group('Navigation Tests: Task List → Task Detail', () {
    const taskTitle = 'Test Task';

    testWidgets('should navigate to TaskDetailScreen when tapping a task', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));

      await tester.enterText(find.byKey(const Key('taskInput')), taskTitle);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      await tester.tap(find.text(taskTitle));
      await tester.pumpAndSettle();

      expect(find.text('Task Detail'), findsOneWidget);
      expect(find.byKey(const Key('detailTitleField')), findsOneWidget);
    });

    testWidgets('should display correct task title in detail screen', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));

      await tester.enterText(find.byKey(const Key('taskInput')), taskTitle);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      await tester.tap(find.text(taskTitle));
      await tester.pumpAndSettle();

      final titleField = find.byKey(const Key('detailTitleField'));
      expect(titleField, findsOneWidget);

      final textField = tester.widget<TextField>(titleField);
      expect(textField.controller?.text, taskTitle);
    });

    testWidgets('should show AppBar title "Task Detail" on detail screen', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));

      await tester.enterText(find.byKey(const Key('taskInput')), taskTitle);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      await tester.tap(find.text(taskTitle));
      await tester.pumpAndSettle();

      expect(find.text('Task Detail'), findsOneWidget);
    });
  });
}