// test/lab11/test_helpers.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/lab11/providers/task_provider.dart';
import '../../lib/lab11/repositories/task_repository.dart';

// Helper để tạo widget testable với ProviderScope
Widget createTestableWidget(Widget child) {
  return ProviderScope(
    overrides: [
      taskRepositoryProvider.overrideWith((ref) => TaskRepository()),
    ],
    child: MaterialApp(
      home: child,
    ),
  );
}

// Helper để lấy repository từ ProviderScope thông qua element
TaskRepository getTestRepository(WidgetTester tester) {
  // Tìm ProviderScope widget trong tree
  final providerScope = tester.widget<ProviderScope>(
      find.byType(ProviderScope).first
  );

  // Lấy container từ ProviderScope
  // Cách 1: Sử dụng ProviderScope.containerOf (static method)
  final container = ProviderScope.containerOf(
      tester.element(find.byType(ProviderScope).first)
  );

  return container.read(taskRepositoryProvider);
}

// Helper để seed tasks cho testing
Future<void> seedTasks(WidgetTester tester, List<String> taskTitles) async {
  final repository = getTestRepository(tester);
  for (final title in taskTitles) {
    repository.addTask(title);
  }
  await tester.pump();
}

// Alternative helper: Tạo test widget với custom container
class TestWidget extends StatelessWidget {
  final Widget child;
  final ProviderContainer? container;

  const TestWidget({
    super.key,
    required this.child,
    this.container,
  });

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: container ?? ProviderContainer(),
      child: MaterialApp(
        home: child,
      ),
    );
  }
}

// Helper để tạo widget với container có thể truy cập
Future<ProviderContainer> createTestWidget(
    WidgetTester tester,
    Widget widget,
    ) async {
  final container = ProviderContainer(
    overrides: [
      taskRepositoryProvider.overrideWith((ref) => TaskRepository()),
    ],
  );

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: widget,
      ),
    ),
  );

  return container;
}