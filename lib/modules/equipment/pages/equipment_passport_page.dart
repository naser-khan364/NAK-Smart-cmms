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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    equipment.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text('کد تجهیز: ${equipment.code}'),
                  Text('نوع: ${equipment.type}'),
                  Text('مکان: ${equipment.location}'),
                  Text('سازنده: ${equipment.manufacturer}'),
                  Text('مدل: ${equipment.model}'),
                  Text(
                    'MTBF: ${equipment.mtbf.toStringAsFixed(0)} ساعت',
                  ),
                  Text(
                    'MTTR: ${equipment.mttr.toStringAsFixed(0)} دقیقه',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
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
