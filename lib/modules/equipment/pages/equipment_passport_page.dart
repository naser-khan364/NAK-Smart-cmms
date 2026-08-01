import 'package:flutter/material.dart';

import '../models/equipment_models.dart';
import '../../spare_parts/models/equipment_part_mock_data.dart';
import '../../spare_parts/models/spare_part_mock_data.dart';

class EquipmentPassportPage extends StatelessWidget {
  final Equipment equipment;

  const EquipmentPassportPage({
    super.key,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    final equipmentParts = equipmentPartMockData
        .where((item) => item.equipmentId == equipment.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('پاسپورت تجهیز | ${equipment.code}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 8),
                    Text('کد تجهیز: ${equipment.code}'),
                    Text('نوع: ${equipment.type}'),
                    Text('محل: ${equipment.location}'),
                    Text(
                      'سازنده: ${equipment.manufacturer} | مدل: ${equipment.model}',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          equipment.statusLabel,
                          style: TextStyle(
                            color: equipment.statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Text('MTBF: ${equipment.mtbf.toStringAsFixed(0)} h'),
                        const SizedBox(width: 16),
                        Text('MTTR: ${equipment.mttr.toStringAsFixed(0)} min'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'قطعات مرتبط',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            if (equipmentParts.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('برای این تجهیز قطعه‌ای ثبت نشده است.'),
                ),
              )
            else
              ...equipmentParts.map(
                (relation) {
                  final part = sparePartMockData.firstWhere(
                    (item) => item.id == relation.sparePartId,
                  );

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.settings_outlined),
                      ),
                      title: Text(
                        '${part.code} | ${part.name}',
                      ),
                      subtitle: Text(
                        'واحد: ${part.unit}\n'
                        'موجودی: ${part.quantity} | '
                        'حداقل موجودی: ${part.minimumStock}\n'
                        'مقدار موردنیاز برای تجهیز: ${relation.requiredQuantity}',
                      ),
                      isThreeLine: true,
                      trailing: Icon(part.isBelowMinimum
                            ? Icons.warning_amber_rounded
                            : Icons.check_circle_outline,
                        color: part.isBelowMinimum
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
