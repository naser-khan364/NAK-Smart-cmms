import 'package:flutter/material.dart';

import '../models/equipment_mock_data.dart';
import '../models/equipment_models.dart';
import 'equipment_passport_page.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final equipment = equipmentMockData;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تجهیزات',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'فهرست تجهیزات و وضعیت عملکردی آن‌ها',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _SummaryCard(
                title: 'کل تجهیزات',
                value: '${equipment.length}',
                icon: Icons.precision_manufacturing_outlined,
              ),
              _SummaryCard(
                title: 'در حال کار',
                value:
                    '${equipment.where((e) => e.status == EquipmentStatus.operational).length}',
                icon: Icons.check_circle_outline,
              ),
              _SummaryCard(
                title: 'در تعمیرات',
                value:
                    '${equipment.where((e) => e.status == EquipmentStatus.maintenance).length}',
                icon: Icons.build_circle_outlined,
              ),
              _SummaryCard(
                title: 'متوقف',
                value:
                    '${equipment.where((e) => e.status == EquipmentStatus.stopped).length}',
                icon: Icons.pause_circle_outline,
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
                    'فهرست تجهیزات',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),

                  ...equipment.map(
                    (item) => _EquipmentTile(
                      equipment: item,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EquipmentPassportPage(
                              equipment: item,
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

class _EquipmentTile extends StatelessWidget {
  final Equipment equipment;
  final VoidCallback onTap;const _EquipmentTile({
    required this.equipment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(
            Icons.precision_manufacturing_outlined,
            color: equipment.statusColor,
          ),
        ),
        title: Text(
          '${equipment.code} | ${equipment.name}',
        ),
        subtitle: Text(
          '${equipment.type}\n'
          '${equipment.location} | ${equipment.manufacturer} ${equipment.model}\n'
          'MTBF: ${equipment.mtbf.toStringAsFixed(0)} h | '
          'MTTR: ${equipment.mttr.toStringAsFixed(0)} min',
        ),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              equipment.statusLabel,
              style: TextStyle(
                color: equipment.statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Icon(Icons.chevron_left),
          ],
        ),
      ),
    );
  }
}
