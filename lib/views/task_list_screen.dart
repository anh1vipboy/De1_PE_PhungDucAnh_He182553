import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';
import '../repositories/theme_repository.dart';
import '../viewmodels/task_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import 'task_edit_screen.dart';
import 'widgets/color_picker_dialog.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  IconData _getIconData(String iconType) {
    switch (iconType) {
      case 'book':
        return Icons.menu_book_outlined;
      case 'note':
        return Icons.assignment_outlined;
      case 'laptop':
      default:
        return Icons.laptop_mac_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lắng nghe danh sách công việc từ Riverpod
    final tasksAsync = ref.watch(taskViewModelProvider);

    // Lắng nghe màu AppBar từ SharedPreferences qua Riverpod
    final themeAsync = ref.watch(themeViewModelProvider);
    final appBarColor = themeAsync.value ?? ThemeRepository.defaultColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        title: const Text(
          'Quản lý công việc',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          // Nút mở hộp thoại chọn màu AppBar (Yêu cầu 3)
          IconButton(
            icon: const Icon(Icons.palette_outlined, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ColorPickerDialog(),
              );
            },
          ),
        ],
      ),
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Lỗi tải dữ liệu: $err')),
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có công việc nào',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final Task task = tasks[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Icon bên trái
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getIconData(task.iconType),
                        color: const Color(0xFF4A5568),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Tiêu đề & Hạn chót / Mô tả
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A202C),
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 13,
                                color: Color(0xFF718096),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  task.subtitle.isNotEmpty
                                      ? task.subtitle
                                      : task.description,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF718096),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Nút chỉnh sửa công việc (Yêu cầu 2)
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Color(0xFF4A5568),
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskEditScreen(task: task),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF4A5568),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
