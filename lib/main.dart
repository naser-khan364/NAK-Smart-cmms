import 'package:flutter/material.dart';
import 'core/theme/nak_theme.dart';
import 'core/layout/nak_app_shell.dart';

void main() {
  runApp(const NakSmartApp());
}

class NakSmartApp extends StatelessWidget {
  const NakSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NAK Smart',
      theme: NakTheme.light(),
      home: const NakAppShell(),
    );
  }
}
