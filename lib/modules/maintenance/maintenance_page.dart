import 'package:flutter/material.dart';

import 'models/maintenance_mock_data.dart';
import 'models/maintenance_models.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  String _search = '';
  WorkOrderStatus? _statusFilter;
  WorkOrderPriority? _priorityFilter;
  WorkOrderType? _typeFilter;

  Color _statusColor(WorkOrderStatus status) {
    switch (status) {
      case WorkOrderStatus.pending:
        return Colors.orange;
      case WorkOrderStatus.inProgress:
        return Colors.blue;
      case WorkOrderStatus.completed:
        return Colors.green;
      case WorkOrderStatus.cancelled:
        return Colors.grey;
    }
  }

  Color _priorityColor(WorkOrderPriority priority) {
    switch (priority) {
      case WorkOrderPriority.low:
        return Colors.green;
      case WorkOrderPriority.medium:
        return Colors.orange;
      case WorkOrderPriority.high:
        return Colors.deepOrange;
      case WorkOrderPriority.critical:
        return Colors.red;
    }
  }

  List<MaintenanceWorkOrder> get _filteredOrders {
    final query = _search.trim().toLowerCase();

    return maintenanceMockWorkOrders.where((order) {
      final matchesSearch =
          query.isEmpty ||
          order.id.toLowerCase().contains(query) ||
          order.equipment.toLowerCase().contains(query) ||
          order.title.toLowerCase().contains(query) ||
          order.requester.toLowerCase().contains(query) ||
          order.assignedTo.toLowerCase().contains(query);

      final matchesStatus =
          _statusFilter == null || order.status == _statusFilter;

      final matchesPriority =
          _priorityFilter == null || order.priority == _priorityFilter;

      final matchesType = _typeFilter == null || order.type == _typeFilter;

      return matchesSearch &&
          matchesStatus &&
          matchesPriority &&
          matchesType;
    }).toList();
  }

  void _clearFilters() {
    setState(() {
      _search = '';
      _statusFilter = null;
      _priorityFilter = null;
      _typeFilter = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = _filteredOrders;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '??????? ? ???????',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _SummaryCard(
                title: '?? ??????????',
                value: '${maintenanceMockWorkOrders.length}',
                icon: Icons.assignment_outlined,
              ),
              _SummaryCard(
                title: '?? ??? ?????',
                value:
                    '${maintenanceMockWorkOrders.where((e) => e.status == WorkOrderStatus.inProgress).length}',
                icon: Icons.build_circle_outlined,
              ),
              _SummaryCard(
                title: 'PM',
                value:
                    '${maintenanceMockWorkOrders.where((e) => e.type == WorkOrderType.preventive).length}',
                icon: Icons.event_note_outlined,
              ),
              _SummaryCard(
                title: 'EM',
                value:
                    '${maintenanceMockWorkOrders.where((e) => e.type == WorkOrderType.corrective).length}',
                icon: Icons.warning_amber_outlined,
              ),
            ],
          ),

          const SizedBox(height: 24),Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: '????? ????????',
                      hintText: '?? ??? ??????? ??????? ??????? ??????',
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _search = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      DropdownButton<WorkOrderStatus?>(
                        value: _statusFilter,
                        hint: const Text('????? ?????'),
                        items: [
                          const DropdownMenuItem<WorkOrderStatus?>(
                            value: null,
                            child: Text('??? ?????'),
                          ),
                          ...WorkOrderStatus.values.map(
                            (status) => DropdownMenuItem<WorkOrderStatus?>(
                              value: status,
                              child: Text(status.label),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _statusFilter = value;
                          });
                        },
                      ),

                      DropdownButton<WorkOrderPriority?>(
                        value: _priorityFilter,
                        hint: const Text('????? ???????'),
                        items: [
                          const DropdownMenuItem<WorkOrderPriority?>(
                            value: null,
                            child: Text('??? ???????'),
                          ),
                          ...WorkOrderPriority.values.map(
                            (priority) =>
                                DropdownMenuItem<WorkOrderPriority?>(
                              value: priority,
                              child: Text(priority.label),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _priorityFilter = value;
                          });
                        },
                      ),

                      DropdownButton<WorkOrderType?>(
                        value: _typeFilter,
                        hint: const Text('??? ?????'),
                        items: [
                          const DropdownMenuItem<WorkOrderType?>(
                            value: null,
                            child: Text('??? ?????'),
                          ),
                          ...WorkOrderType.values.map(
                            (type) => DropdownMenuItem<WorkOrderType?>(
                              value: type,
                              child: Text(type.label),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _typeFilter = value;
                          });
                        },
                      ),

                      OutlinedButton.icon(
                        onPressed: _clearFilters,
                        icon: const Icon(Icons.clear_all),
                        label: const Text('??? ?????'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),Row(
            children: [
              Text(
                '??????????? ???????',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Text(
                '${orders.length} ????',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (orders.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Text('???? ?????? ??? ?????.'),
                ),
              ),
            )
          else
            ...orders.map(
              (order) => _WorkOrderTile(
                order: order,
                statusColor: _statusColor(order.status),
                priorityColor: _priorityColor(order.priority),
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

class _WorkOrderTile extends StatelessWidget {
  final MaintenanceWorkOrder order;
  final Color statusColor;
  final Color priorityColor;

  const _WorkOrderTile({
    required this.order,
    required this.statusColor,
    required this.priorityColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(order.type.label),
        ),
        title: Text(order.title),
        subtitle: Text(
          '${order.id}  |  ${order.equipment}\n'
          '${order.requester}  |  ${order.assignedTo}',
        ),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              order.status.label,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              order.priority.label,
              style: TextStyle(
                color: priorityColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
