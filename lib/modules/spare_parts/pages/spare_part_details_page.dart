import 'package:flutter/material.dart';

import '../models/spare_part_models.dart';
import '../models/spare_part_mock_data.dart';

class SparePartDetailsPage extends StatelessWidget {
  final SparePart part;

  const SparePartDetailsPage({
    super.key,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(part.code),
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
                    part.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text('کد قطعه: ${part.code}'),
                  Text('واحد: ${part.unit}'),
                  Text('موجودی: ${part.quantity}'),
                  Text('حداقل موجودی: ${part.minimumStock}'),
                  Text('قیمت واحد: ${part.unitPrice}'),
                  Text('تأمین‌کننده: ${part.supplier}'),
                  Text('کد قطعه نزد تأمین‌کننده: ${part.supplierPartCode}'),
                  Text('زمان تأمین: ${part.leadTimeDays} روز'),
                  Text('اهمیت قطعه: '),
                  const SizedBox(height: 6),
                  Text(
                    part.isBelowMinimum
                        ? 'وضعیت موجودی: زیر حداقل'
                        : 'وضعیت موجودی: مناسب',
                  ),
                  const SizedBox(height: 6),
                  Text(
                    part.isBelowMinimum
                        ? 'کسری موجودی:  '
                        : 'وضعیت تأمین: موجودی کافی',
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

class SparePartsDetailsListPage extends StatelessWidget {
  const SparePartsDetailsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: sparePartMockData.map((part) {
        return Card(
          child: ListTile(
            title: Text(part.name),
            subtitle: Text(
              '${part.code} | موجودی: ${part.quantity} ${part.unit}',
            ),
            trailing: Icon(
              part.isBelowMinimum
                  ? Icons.warning_amber_outlined
                  : Icons.check_circle_outline,
              color: part.isBelowMinimum ? Colors.red : Colors.green,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SparePartDetailsPage(part: part),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
