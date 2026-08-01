import 'package:flutter/material.dart';

import '../models/equipment_mock_data.dart';
import '../models/equipment_models.dart';
import 'equipment_passport_page.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  String search = '';
  EquipmentStatus? statusFilter;

  @override
  Widget build(BuildContext context) {
    final filtered = equipmentMockData.where((e) {
      final q = search.trim().toLowerCase();

      final matchesSearch = q.isEmpty ||
          e.code.toLowerCase().contains(q) ||
          e.name.toLowerCase().contains(q) ||
          e.location.toLowerCase().contains(q) ||
          e.manufacturer.toLowerCase().contains(q);

      final matchesStatus =
          statusFilter == null || e.status == statusFilter;

      return matchesSearch && matchesStatus;
    }).toList();

    final total = equipmentMockData.length;
    final operational = equipmentMockData
        .where((e) => e.status == EquipmentStatus.operational)
        .length;
    final maintenance = equipmentMockData
        .where((e) => e.status == EquipmentStatus.maintenance)
        .length;
    final stopped = equipmentMockData
        .where((e) => e.status == EquipmentStatus.stopped)
        .length;

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
                value: '$total',
                icon: Icons.precision_manufacturing_outlined,
              ),
              _SummaryCard(
                title: 'در حال کار',
                value: '$operational',
                icon: Icons.check_circle_outline,
              ),
              _SummaryCard(
                title: 'در تعمیرات',
                value: '$maintenance',
                icon: Icons.build_circle_outlined,
              ),
              _SummaryCard(
                title: 'متوقف',
                value: '$stopped',
                icon: Icons.pause_circle_outline,
              ),
            ],
          ),

          const SizedBox(height: 24),

          TextField(
            decoration: InputDecoration(
              labelText: 'جست‌وجوی تجهیز',
              hintText: 'کد، نام، مکان یا سازنده',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: search.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => search = ''),
                    ),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => search = value),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('همه'),
                selected: statusFilter == null,
                onSelected: (_) => setState(() => statusFilter = null),
              ),
              FilterChip(
                label: const Text('در حال کار'),
                selected: statusFilter == EquipmentStatus.operational,
                onSelected: (_) => setState(() => statusFilter = EquipmentStatus.operational,
                ),
              ),
              FilterChip(
                label: const Text('در تعمیرات'),
                selected: statusFilter == EquipmentStatus.maintenance,
                onSelected: (_) => setState(
                  () => statusFilter = EquipmentStatus.maintenance,
                ),
              ),
              FilterChip(
                label: const Text('متوقف'),
                selected: statusFilter == EquipmentStatus.stopped,
                onSelected: (_) => setState(
                  () => statusFilter = EquipmentStatus.stopped,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'فهرست تجهیزات (${filtered.length})',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),

                  if (filtered.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text('تجهیزی با این مشخصات پیدا نشد.'),
                      ),
                    )
                  else
                    ...filtered.map(
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
  final VoidCallback onTap;

  const _EquipmentTile({
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
          '${equipment.location} | ${equipment.manufacturer} ${equipment.model}\n''MTBF: ${equipment.mtbf.toStringAsFixed(0)} h | '
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
