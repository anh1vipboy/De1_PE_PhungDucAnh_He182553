import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/theme_repository.dart';
import '../../viewmodels/theme_viewmodel.dart';

class ColorPickerDialog extends ConsumerWidget {
  const ColorPickerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lấy màu hiện tại
    final themeAsync = ref.watch(themeViewModelProvider);
    final currentColor = themeAsync.value ?? ThemeRepository.defaultColor;

    final availableColors = [
      {'name': 'Mặc định', 'color': ThemeRepository.defaultColor},
      {'name': 'Xanh dương', 'color': ThemeRepository.blueColor},
      {'name': 'Xanh lá', 'color': ThemeRepository.greenColor},
      {'name': 'Tím', 'color': ThemeRepository.purpleColor},
    ];

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Chọn màu thanh ứng dụng',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: availableColors.map((item) {
          final color = item['color'] as Color;
          final isSelected = (color.toARGB32() == currentColor.toARGB32());

          return GestureDetector(
            onTap: () {
              // Gọi ViewModel đổi màu và lưu SharedPreferences
              ref.read(themeViewModelProvider.notifier).changeColor(color);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 28)
                  : null,
            ),
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Đóng',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
