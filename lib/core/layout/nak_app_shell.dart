import 'package:flutter/material.dart';
import '../../modules/dashboard/dashboard_page.dart';

class NakAppShell extends StatefulWidget {
  const NakAppShell({super.key});

  @override
  State<NakAppShell> createState() => _NakAppShellState();
}

class _NakAppShellState extends State<NakAppShell> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'داشبورد',
    'تعمیرات و نگهداری',
    'تولید',
    'انبار',
    'تنظیمات',
  ];

  static const List<IconData> _icons = [
    Icons.dashboard_outlined,
    Icons.build_outlined,
    Icons.precision_manufacturing_outlined,
    Icons.inventory_2_outlined,
    Icons.settings_outlined,
  ];

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardPage();

      default:
        return Center(
          child: Text(
            _titles[_selectedIndex],
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NAK Smart | ${_titles[_selectedIndex]}'),
      ),
      body: _buildPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: List.generate(
          _titles.length,
          (index) => NavigationDestination(
            icon: Icon(_icons[index]),
            label: _titles[index],
          ),
        ),
      ),
    );
  }
}
