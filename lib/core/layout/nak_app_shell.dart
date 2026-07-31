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

      case 1:
        return const _ModulePlaceholderPage(
          icon: Icons.build_outlined,
          title: 'تعمیرات و نگهداری',
          description:
              'مدیریت درخواست‌های تعمیر، دستورکارها، PM، EM و فعالیت‌های نگهداری',
          items: [
            'درخواست‌های تعمیر',
            'دستورکارها',
            'PM',
            'EM',
          ],
        );

      case 2:
        return const _ModulePlaceholderPage(
          icon: Icons.precision_manufacturing_outlined,
          title: 'تولید',
          description:
              'نمایش وضعیت تولید، تجهیزات تولیدی و ارتباط فعالیت‌های تولید با نگهداری',
          items: [
            'وضعیت خطوط تولید',
            'تجهیزات تولید',
            'توقفات تولید',
          ],
        );

      case 3:
        return const _ModulePlaceholderPage(
          icon: Icons.inventory_2_outlined,
          title: 'انبار',
          description:
              'مشاهده موجودی قطعات یدکی و وضعیت حداقل موجودی',
          items: [
            'موجودی قطعات',
            'حداقل موجودی',
            'قطعات بحرانی',
          ],
        );

      case 4:
        return const _ModulePlaceholderPage(
          icon: Icons.settings_outlined,
          title: 'تنظیمات',
          description:
              'مدیریت اطلاعات پایه، کاربران، نقش‌ها و تنظیمات سیستم',
          items: [
            'کاربران و نقش‌ها',
            'اطلاعات پایه',
            'تنظیمات سیستم',
          ],
        );

      default:
        return const DashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NAK Smart | ${_titles[_selectedIndex]}',
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: _buildPage(),
        ),
      ),
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
            selectedIcon: Icon(_icons[index]),
            label: _titles[index],
          ),
        ),
      ),
    );
  }
}

class _ModulePlaceholderPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> items;

  const _ModulePlaceholderPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const SizedBox(height: 30),

              Icon(
                icon,
                size: 72,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(height: 20),Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),

              const SizedBox(height: 32),

              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 700 ? 3 : 1;
                  final spacing = 16.0;

                  final cardWidth = columns == 1
                      ? constraints.maxWidth
                      : (constraints.maxWidth -
                              ((columns - 1) * spacing)) /
                          columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: items
                        .map(
                          (item) => SizedBox(
                            width: cardWidth,
                            child: Card(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 18,
                                        color: theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
