import 'package:flutter/material.dart';

import '../../spare_parts/models/equipment_part_models.dart';
import '../../spare_parts/models/spare_part_mock_data.dart';
import '../../spare_parts/pages/spare_part_details_page.dart';

class EquipmentPartsPage extends StatelessWidget {
  final String equipmentId;

  const EquipmentPartsPage({
    super.key,
    required this.equipmentId,
  });

  @override
  Widget build(BuildContext context) {
    final parts = equipmentPartMockData
        .where((item) => item.equipmentId == equipmentId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('قطعات یدکی تجهیز $equipmentId'),
      ),
      body: parts.isEmpty
          ? const Center(
              child: Text('برای این تجهیز قطعه‌ای ثبت نشده است.'),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.inventory_2_outlined,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'BOM و وضعیت قطعات یدکی',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge,
                          ),
                        ),
                        Text(
                          '${parts.length} قطعه',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ...parts.map(
                  (item) => _EquipmentPartCard(
                    item: item,
                  ),
                ),
              ],
            ),
    );
  }
}

class _EquipmentPartCard extends StatelessWidget {
  final EquipmentPart item;

  const _EquipmentPartCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final sparePart = sparePartMockData.firstWhere(
      (part) => part.id == item.sparePartId,
    );

    final belowMinimum = sparePart.isBelowMinimum;
    final shortage = item.requiredQuantity > sparePart.quantity
        ? item.requiredQuantity - sparePart.quantity
        : 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            belowMinimum
                ? Icons.warning_amber_rounded
                : Icons.inventory_2_outlined,
          ),
        ),
        title: Text(sparePart.name),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('کد: ${sparePart.code}'),
              const SizedBox(height: 3),
              Text(
                'مقدار موردنیاز: '
                '${item.requiredQuantity} ${sparePart.unit}',
              ),
              const SizedBox(height: 3),
              Text(
                'موجودی: '
                '${sparePart.quantity} ${sparePart.unit}',
              ),
              const SizedBox(height: 3),
              Text(
                'حداقل موجودی: '
                '${sparePart.minimumStock} ${sparePart.unit}',
              ),
              const SizedBox(height: 6),
              Text(
                belowMinimum
                    ? 'هشدار: موجودی کمتر از حداقل است'
                    : 'وضعیت موجودی: مناسب',
                style: TextStyle(color: shortage > 0 || belowMinimum ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_left),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SparePartDetailsPage(
                part: sparePart,
              ),
            ),
          );
        },
      ),
    );
  }
}





