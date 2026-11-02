class Task {
  final int? id;
  final String title;
  final String description;
  final String subtitle;
  final bool isCompleted;
  final String iconType;

  Task({
    this.id,
    required this.title,
    this.description = '',
    this.subtitle = '',
    this.isCompleted = false,
    this.iconType = 'laptop',
  });

  // Chuyển đối tượng Task thành Map để lưu vào SQLite (Module 9)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subtitle': subtitle,
      'is_completed': isCompleted ? 1 : 0,
      'icon_type': iconType,
    };
  }

  // Khởi tạo đối tượng Task từ Map đọc từ SQLite
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subtitle: map['subtitle'] ?? '',
      isCompleted: (map['is_completed'] == 1),
      iconType: map['icon_type'] ?? 'laptop',
    );
  }

  // Hàm copyWith để cập nhật thông tin dễ dàng
  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? subtitle,
    bool? isCompleted,
    String? iconType,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subtitle: subtitle ?? this.subtitle,
      isCompleted: isCompleted ?? this.isCompleted,
      iconType: iconType ?? this.iconType,
    );
  }
}

