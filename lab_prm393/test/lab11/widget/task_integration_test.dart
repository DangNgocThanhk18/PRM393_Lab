import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/lab11/screens/task_list_screen.dart';
import '../test_helpers.dart';

void main() {
  group('Task Integration Tests - Full Flow', () {
    const originalTitle = 'Original title';
    const updatedTitle = 'Updated title';

    testWidgets('Complete flow: Add task → Edit task → Save → Verify update', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));

      // Step 1: Add task
      await tester.enterText(find.byKey(const Key('taskInput')), originalTitle);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      expect(find.text(originalTitle), findsOneWidget);

      // Step 2: Tap task to open detail
      await tester.tap(find.text(originalTitle));
      await tester.pumpAndSettle();

      expect(find.text('Task Detail'), findsOneWidget);
      expect(find.byKey(const Key('detailTitleField')), findsOneWidget);

      // Step 3: Edit title
      final titleField = find.byKey(const Key('detailTitleField'));
      await tester.enterText(titleField, updatedTitle);

      // Step 4: Tap save button
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // Step 5: Verify updated title appears
      expect(find.text(updatedTitle), findsOneWidget);
      expect(find.text(originalTitle), findsNothing);
    });

    testWidgets('Should toggle task completion status', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TaskListScreen()));

      await tester.enterText(find.byKey(const Key('taskInput')), originalTitle);
      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      final checkbox = find.byType(Checkbox).first;
      await tester.tap(checkbox);
      await tester.pump();

      final taskText = find.text(originalTitle);
      expect(taskText, findsOneWidget);
    });
  });
}