import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nak_smart_cmms/core/layout/nak_app_shell.dart';

void main() {
  testWidgets('NAK Smart application shell smoke test', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NakAppShell(),
      ),
    );

    expect(find.textContaining('NAK Smart'), findsOneWidget);
    expect(find.text('داشبورد'), findsOneWidget);
    expect(find.text('نگهداری و تعمیرات'), findsOneWidget);
    expect(find.text('تجهیزات'), findsWidgets);
    expect(find.text('قطعات یدکی'), findsWidgets);
  });
}
