import 'package:flutter/material.dart';

import 'models/dashboard_mock_data.dart';
import 'models/dashboard_models.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const data = DashboardMockData.sample;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'داشبورد مدیریت نگهداری',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 6),
          Text(
            'نمای کلی وضعیت تجهیزات و فعالیت‌های تعمیرات و نگهداری',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1200
                  ? 4
                  : constraints.maxWidth >= 700
                      ? 2
                      : 1;

              final spacing = 16.0;
              final cardWidth = columns == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - ((columns - 1) * spacing)) /
                      columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: data.kpis
                    .map(
                      (kpi) => _KpiCard(
                        width: cardWidth,
                        kpi: kpi,
                      ),
                    )
                    .toList(),
              );
            },
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;

              final statusCard = _EquipmentStatusCard(
                summary: data.equipmentStatus,
              );

              final indicatorCard = _MaintenanceIndicatorsCard(
                mtbf: data.mtbf,
                mttr: data.mttr,
                availability: data.availability,
                pmCompliance: data.pmCompliance,
              );

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: statusCard),
                    const SizedBox(width: 16),
                    Expanded(child: indicatorCard),
                  ],
                );
              }

              return Column(
                children: [
                  statusCard,
                  const SizedBox(height: 16),
                  indicatorCard,
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          _RecentRequestsCard(
            requests: data.recentRequests,
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final double width;
  final DashboardKpi kpi;

  const _KpiCard({
    required this.width,
    required this.kpi,
  });

  IconData get _icon {
    switch (kpi.title) {
      case 'تجهیزات':
        return Icons.precision_manufacturing_outlined;
      case 'خرابی‌های باز':
        return Icons.warning_amber_outlined;
      case 'PM سررسیدشده':
        return Icons.event_note_outlined;
      default:
        return Icons.build_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color iconColor;
    switch (kpi.status) {
      case DashboardKpiStatus.normal:
        iconColor = colorScheme.primary;
      case DashboardKpiStatus.warning:
        iconColor = Colors.orange.shade700;
      case DashboardKpiStatus.critical:
        iconColor = colorScheme.error;
    }return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _icon,
                  color: iconColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kpi.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      kpi.value,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      kpi.subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EquipmentStatusCard extends StatelessWidget {
  final EquipmentStatusSummary summary;

  const _EquipmentStatusCard({
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'وضعیت تجهیزات',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            _StatusRow(
              title: 'در حال کار',
              value: summary.running,
              total: summary.total,
              icon: Icons.play_circle_outline,
            ),
            _StatusRow(
              title: 'متوقف',
              value: summary.stopped,
              total: summary.total,
              icon: Icons.stop_circle_outlined,
            ),
            _StatusRow(
              title: 'در تعمیرات',
              value: summary.underMaintenance,
              total: summary.total,
              icon: Icons.build_circle_outlined,
            ),
            _StatusRow(
              title: 'بحرانی',
              value: summary.critical,
              total: summary.total,
              icon: Icons.error_outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String title;
  final int value;
  final int total;
  final IconData icon;

  const _StatusRow({
    required this.title,
    required this.value,
    required this.total,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : value / total;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 22),
              const SizedBox(width: 10),
              Expanded(child: Text(title)),
              Text(
                '$value',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          LinearProgressIndicator(
            value: ratio,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}

class _MaintenanceIndicatorsCard extends StatelessWidget {
  final String mtbf;
  final String mttr;
  final String availability;
  final String pmCompliance;const _MaintenanceIndicatorsCard({
    required this.mtbf,
    required this.mttr,
    required this.availability,
    required this.pmCompliance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'شاخص‌های نگهداری',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _IndicatorRow(title: 'MTBF', value: mtbf),
            _IndicatorRow(title: 'MTTR', value: mttr),
            _IndicatorRow(
              title: 'Availability',
              value: availability,
            ),
            _IndicatorRow(
              title: 'PM Compliance',
              value: pmCompliance,
            ),
          ],
        ),
      ),
    );
  }
}

class _IndicatorRow extends StatelessWidget {
  final String title;
  final String value;

  const _IndicatorRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentRequestsCard extends StatelessWidget {
  final List<MaintenanceRequest> requests;

  const _RecentRequestsCard({
    required this.requests,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'آخرین درخواست‌های تعمیر',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...requests.map(
              (request) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  child: Text(
                    request.requestNo.replaceAll('MR-', ''),
                  ),
                ),
                title: Text(request.equipment),
                subtitle: Text(request.description),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(request.priority),
                    const SizedBox(height: 4),
                    Text(
                      request.status,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
