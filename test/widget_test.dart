import 'package:flutter_test/flutter_test.dart';
import 'package:nak_smart_cmms/main.dart';

void main() {
  testWidgets('NAK Smart application shell smoke test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NakSmartApp());

    expect(find.text('NAK Smart | داشبورد'), findsOneWidget);
    expect(find.text('داشبورد'), findsWidgets);
    expect(find.text('تعمیرات و نگهداری'), findsOneWidget);
    expect(find.text('تولید'), findsOneWidget);
    expect(find.text('انبار'), findsOneWidget);
    expect(find.text('تنظیمات'), findsOneWidget);
  });
}
