import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/theme_repository.dart';

part 'theme_viewmodel.g.dart';

@riverpod
class ThemeViewModel extends _$ThemeViewModel {
  final ThemeRepository _repository = ThemeRepository();

  @override
  Future<Color> build() async {
    // Đọc màu đã lưu trong SharedPreferences khi khởi động app
    return _repository.getSavedColor();
  }

  // Đổi màu và lưu vào SharedPreferences (Yêu cầu 3)
  Future<void> changeColor(Color newColor) async {
    await _repository.saveColor(newColor);
    state = AsyncValue.data(newColor);
  }
}

