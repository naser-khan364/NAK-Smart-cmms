import 'package:flutter/material.dart';

import '../models/equipment_models.dart';
import 'equipment_parts_page.dart';

class EquipmentPassportPage extends StatelessWidget {
  final Equipment equipment;

  const EquipmentPassportPage({
    super.key,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شناسنامه ${equipment.code}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.precision_manufacturing_outlined,
                      size: 32,
                      color: equipment.statusColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          equipment.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(equipment.code),
                        const SizedBox(height: 6),
                        Text(
                          equipment.statusLabel,
                          style: TextStyle(
                            color: equipment.statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          _SectionCard(
            title: 'اطلاعات پایه تجهیز',
            icon: Icons.info_outline,
            children: [
              _InfoRow(label: 'کد تجهیز', value: equipment.code),
              _InfoRow(label: 'نوع تجهیز', value: equipment.type),
              _InfoRow(label: 'مکان', value: equipment.location),
              _InfoRow(label: 'واحد سازمانی', value: equipment.department),
              _InfoRow(label: 'سازنده', value: equipment.manufacturer),
              _InfoRow(label: 'مدل', value: equipment.model),
              _InfoRow(label: 'شماره سریال', value: equipment.serialNumber),
              _InfoRow(
                label: 'تاریخ نصب',
                value: equipment.installationDate,
              ),
            ],
          ),

          const SizedBox(height: 16),

          _SectionCard(
            title: 'توضیحات',
            icon: Icons.description_outlined,
            children: [
              Text(equipment.description),
            ],
          ),

          const SizedBox(height: 16),

          _SectionCard(
            title: 'شاخص‌های نگهداری',
            icon: Icons.analytics_outlined,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      title: 'MTBF',
                      value: equipment.mtbf.toStringAsFixed(0),
                      unit: 'ساعت',
                      icon: Icons.timer_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MetricCard(
                      title: 'MTTR',
                      value: equipment.mttr.toStringAsFixed(0),
                      unit: 'دقیقه',
                      icon: Icons.build_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),Card(
            child: ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: const Text('قطعات یدکی تجهیز'),
              subtitle: const Text(
                'مشاهده قطعات، مقدار موردنیاز و وضعیت موجودی',
              ),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EquipmentPartsPage(
                      equipmentId: equipment.id,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(unit),
        ],
      ),
    );
  }
}
