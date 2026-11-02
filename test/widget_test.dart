import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:de1/main.dart';

void main() {
  testWidgets('Hiển thị màn hình Quản lý công việc', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    expect(find.text('Quản lý công việc'), findsOneWidget);
  });
}
