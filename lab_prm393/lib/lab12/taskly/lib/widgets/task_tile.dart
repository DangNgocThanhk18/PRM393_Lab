import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/task_detail_screen.dart';
import '../utils/app_constants.dart';

/// Widget hiển thị một task trong danh sách
/// Đã được tối ưu với const constructor và ValueKey
class TaskTile extends ConsumerWidget {
  final Task task;

  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      key: ValueKey(task.id), // ✅ Giúp Flutter xác định widget nào cần rebuild
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) {
          ref.read(taskListProvider.notifier).toggleTask(task.id);
        },
      ),
      title: Text(
        task.title,
        style: task.isCompleted
            ? AppStyles.completedTaskStyle
            : AppStyles.normalTaskStyle,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailScreen(task: task),
          ),
        );
      },
    );
  }
}