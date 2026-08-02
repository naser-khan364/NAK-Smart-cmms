import 'package:flutter/material.dart';

import '../models/spare_part_models.dart';
import '../models/spare_part_mock_data.dart';
import 'spare_part_details_page.dart';

class SparePartsPage extends StatelessWidget {
  const SparePartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final parts = sparePartMockData;

    final totalQuantity = parts.fold<double>(
      0,
      (sum, part) => sum + part.quantity,
    );

    final belowMinimum = parts.where(
      (part) => part.isBelowMinimum,
    ).length;

    final criticalParts = parts.where(
      (part) =>
          part.criticality == SparePartCriticality.critical,
    ).length;

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
            'مدیریت قطعات، موجودی و حداقل موجودی موردنیاز تجهیزات',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _SummaryCard(
                title: 'تعداد قطعات',
                value: '${parts.length}',
                icon: Icons.inventory_2_outlined,
              ),
              _SummaryCard(
                title: 'موجودی کل',
                value: '$totalQuantity',
                icon: Icons.warehouse_outlined,
              ),
              _SummaryCard(
                title: 'زیر حداقل موجودی',
                value: '$belowMinimum',
                icon: Icons.warning_amber_rounded,
              ),
              _SummaryCard(
                title: 'قطعات بحرانی',
                value: '$criticalParts',
                icon: Icons.priority_high_rounded,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'فهرست قطعات یدکی',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...parts.map(
                    (part) => _SparePartTile(
                      part: part,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SparePartDetailsPage(
                              part: part,
                            ),
                          ),
                        );
                      },
                    ),
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

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 34),
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
}class _SparePartTile extends StatelessWidget {
  final SparePart part;
  final VoidCallback onTap;

  const _SparePartTile({
    required this.part,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLowStock = part.isBelowMinimum;
    final isCritical =
        part.criticality == SparePartCriticality.critical;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(
            isLowStock
                ? Icons.warning_amber_rounded
                : Icons.inventory_2_outlined,
          ),
        ),
        title: Text(
          '${part.code} | ${part.name}',
        ),
        subtitle: Text(
          'واحد: ${part.unit}\n'
          'موجودی: ${part.quantity} | '
          'حداقل: ${part.minimumStock}\n'
          'اهمیت: ${_criticalityLabel(part.criticality)}',
        ),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLowStock ? 'نیاز به تأمین' : 'موجود',
              style: TextStyle(
                color: isLowStock ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isCritical) ...[
              const SizedBox(height: 4),
              const Text(
                'بحرانی',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 4),
            const Icon(Icons.chevron_left),
          ],
        ),
      ),
    );
  }

  String _criticalityLabel(SparePartCriticality criticality) {
    switch (criticality) {
      case SparePartCriticality.low:
        return 'کم';
      case SparePartCriticality.medium:
        return 'متوسط';
      case SparePartCriticality.high:
        return 'زیاد';
      case SparePartCriticality.critical:
        return 'بحرانی';
    }
  }
}
