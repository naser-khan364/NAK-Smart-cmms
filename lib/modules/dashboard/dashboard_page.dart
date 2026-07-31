import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'داشبورد',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width >= 1100
                  ? 4
                  : width >= 700
                      ? 2
                      : 1;

              final cardWidth =
                  (width - ((columns - 1) * 16)) / columns;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _MetricCard(
                    width: cardWidth,
                    title: 'تجهیزات',
                    value: '0',
                    icon: Icons.precision_manufacturing_outlined,
                  ),
                  _MetricCard(
                    width: cardWidth,
                    title: 'خرابی‌های باز',
                    value: '0',
                    icon: Icons.warning_amber_outlined,
                  ),
                  _MetricCard(
                    width: cardWidth,
                    title: 'PM جاری',
                    value: '0',
                    icon: Icons.event_note_outlined,
                  ),
                  _MetricCard(
                    width: cardWidth,
                    title: 'درخواست‌های تعمیر',
                    value: '0',
                    icon: Icons.build_outlined,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'شاخص‌های نگهداری',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  const _IndicatorRow(
                    title: 'MTBF',
                    value: '---',
                  ),
                  const _IndicatorRow(
                    title: 'MTTR',
                    value: '---',
                  ),
                  const _IndicatorRow(
                    title: 'Availability',
                    value: '---',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final double width;
  final String title;
  final String value;
  final IconData icon;

  const _MetricCard({
    required this.width,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 36),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorRow extends StatelessWidget {
  final String title;
  final String value;

  const _IndicatorRow({
    required this.title,
    required this.value,
  });@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
