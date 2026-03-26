import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import '../utils/app_constants.dart';

/// Màn hình chính hiển thị danh sách tasks
/// Đã được tối ưu với Consumer pattern
class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    final title = _controller.text.trim();
    if (title.isNotEmpty) {
      ref.read(taskListProvider.notifier).addTask(title);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly'),
        leading: Padding(
          padding: AppConstants.imagePadding,
          child: Image.asset(
            'assets/images/task_icon.png',
            width: AppConstants.iconSize,
            height: AppConstants.iconSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: AppConstants.listPadding,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('taskInput'),
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new task...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  key: const Key('addButton'),
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                // ✅ Chỉ watch danh sách tasks, không watch toàn bộ state
                final tasks = ref.watch(taskListProvider);

                if (tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      'No tasks yet. Add one!',
                      key: Key('emptyStateText'),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskTile(task: task);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}