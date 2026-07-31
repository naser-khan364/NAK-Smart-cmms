import 'package:flutter/material.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      home: const NakHomePage(),
    );
  }
}

class NakHomePage extends StatelessWidget {
  const NakHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NAK Smart'),
      ),
      body: const Center(
        child: Text(
          'NAK Smart CMMS',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
