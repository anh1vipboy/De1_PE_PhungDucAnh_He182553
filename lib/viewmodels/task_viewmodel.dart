import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/task.dart';
import '../repositories/database_helper.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  @override
  Future<List<Task>> build() async {
    // Nạp dữ liệu từ SQLite khi khởi động
    return DatabaseHelper.instance.getTasks();
  }

  // Tải lại danh sách
  Future<void> loadTasks() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => DatabaseHelper.instance.getTasks());
  }

  // Cập nhật công việc và làm mới giao diện (Yêu cầu 2)
  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    // Đọc lại danh sách mới nhất từ SQLite và cập nhật state
    final updatedList = await DatabaseHelper.instance.getTasks();
    state = AsyncValue.data(updatedList);
  }
}

