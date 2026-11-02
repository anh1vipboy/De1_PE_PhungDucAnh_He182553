import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static const String _keyAppBarColor = 'app_bar_color';

  // 3 màu chính theo yêu cầu đề bài (Xanh dương, Xanh lá, Tím) + màu mặc định
  static const Color defaultColor = Color(0xFF2C3E50); // Xanh đen mặc định
  static const Color blueColor = Color(0xFF1976D2);    // Xanh dương
  static const Color greenColor = Color(0xFF388E3C);   // Xanh lá
  static const Color purpleColor = Color(0xFF7B1FA2);  // Tím

  // Lấy màu AppBar đã lưu trong SharedPreferences (Module 9)
  Future<Color> getSavedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final int? colorValue = prefs.getInt(_keyAppBarColor);
    if (colorValue != null) {
      return Color(colorValue);
    }
    return defaultColor;
  }

  // Lưu màu AppBar vào SharedPreferences
  Future<void> saveColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyAppBarColor, color.toARGB32());
  }
}
