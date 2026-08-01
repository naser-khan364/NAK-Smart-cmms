import 'package:flutter/material.dart';

import '../models/spare_part_models.dart';
import '../models/spare_part_mock_data.dart';

class SparePartsPage extends StatelessWidget {
  const SparePartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final parts = sparePartMockData;

    final belowMinimum =
        parts.where((part) => part.isBelowMinimum).toList();

    final critical = parts
        .where((part) => part.criticality == SparePartCriticality.critical)
        .length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'قطعات یدکی',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'مدیریت موجودی، حداقل موجودی و قطعات بحرانی',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _SummaryCard(
                title: 'کل قطعات',
                value: '${parts.length}',
                icon: Icons.inventory_2_outlined,
              ),
              _SummaryCard(
                title: 'زیر حداقل موجودی',
                value: '${belowMinimum.length}',
                icon: Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              _SummaryCard(
                title: 'قطعات بحرانی',
                value: '$critical',
                icon: Icons.priority_high_rounded,
                color: Colors.deepOrange,
              ),
            ],
          ),

          const SizedBox(height: 24),

          if (belowMinimum.isNotEmpty)
            Card(
              color: Colors.red.withValues(alpha: 0.08),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${belowMinimum.length} قطعه '
                        'نیاز به تأمین موجودی دارد.',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'فهرست قطعات',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),

                  ...parts.map(
                    (part) => _SparePartTile(part: part),
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

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [Icon(
                icon,
                size: 34,
                color: color,
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium,
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

class _SparePartTile extends StatelessWidget {
  final SparePart part;

  const _SparePartTile({
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    final isLow = part.isBelowMinimum;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            isLow
                ? Icons.warning_amber_rounded
                : Icons.settings_outlined,
            color: isLow ? Colors.red : null,
          ),
        ),
        title: Text(
          '${part.code} | ${part.name}',
        ),
        subtitle: Text(
          'واحد: ${part.unit}\n'
          'موجودی: ${part.quantity} | '
          'حداقل: ${part.minimumStock}',
        ),
        isThreeLine: true,
        trailing: Text(
          isLow ? 'نیاز به تأمین' : 'مناسب',
          style: TextStyle(
            color: isLow ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
