import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Dữ liệu mẫu khởi tạo (đúng 4 task như trong hình chụp đề bài)
  static final List<Task> _initialTasks = [
    Task(
      id: 1,
      title: 'Làm bài tập Flutter',
      subtitle: 'Hoàn thành trước thứ Sáu',
      description: 'Hoàn thành trước thứ Sáu',
      isCompleted: false,
      iconType: 'laptop',
    ),
    Task(
      id: 2,
      title: 'Ôn tập Riverpod',
      subtitle: 'Xem lại bài giảng MVVM',
      description: 'Xem lại bài giảng MVVM',
      isCompleted: false,
      iconType: 'book',
    ),
    Task(
      id: 3,
      title: 'Chuẩn bị bài thuyết trình',
      subtitle: 'Nhóm 4 - Chủ đề Firebase',
      description: 'Nhóm 4 - Chủ đề Firebase',
      isCompleted: false,
      iconType: 'laptop',
    ),
    Task(
      id: 4,
      title: 'Viết báo cáo môn học',
      subtitle: 'Nộp trên LMS',
      description: 'Nộp trên LMS',
      isCompleted: false,
      iconType: 'note',
    ),
  ];

  // Danh sách tạm khi chạy trên Web (Chrome)
  static final List<Task> _webTasks = List.from(_initialTasks);

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        subtitle TEXT,
        is_completed INTEGER NOT NULL DEFAULT 0,
        icon_type TEXT
      )
    ''');

    // Chèn 4 công việc mẫu ban đầu
    for (var task in _initialTasks) {
      await db.insert('tasks', task.toMap());
    }
  }

  // Yêu cầu 1: Lấy danh sách công việc từ SQLite
  Future<List<Task>> getTasks() async {
    if (kIsWeb) {
      return List.unmodifiable(_webTasks);
    }
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  // Yêu cầu 2: Cập nhật công việc vào SQLite
  Future<int> updateTask(Task task) async {
    if (kIsWeb) {
      final index = _webTasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _webTasks[index] = task;
      }
      return 1;
    }
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Thêm mới công việc
  Future<int> insertTask(Task task) async {
    if (kIsWeb) {
      _webTasks.add(task);
      return _webTasks.length;
    }
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }
}

