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
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: parts.length,
              itemBuilder: (context, index) {
                final item = parts[index];

                final sparePart = sparePartMockData.firstWhere(
                  (part) => part.id == item.sparePartId,
                );

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        sparePart.isBelowMinimum
                            ? Icons.warning_amber_rounded
                            : Icons.inventory_2_outlined,
                      ),
                    ),
                    title: Text(sparePart.name),
                    subtitle: Text(
                      '${sparePart.code} | '
                      'مقدار موردنیاز: ${item.requiredQuantity} ${sparePart.unit}',
                    ),
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
              },
            ),
    );
  }
}
