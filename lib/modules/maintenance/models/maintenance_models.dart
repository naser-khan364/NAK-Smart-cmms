enum WorkOrderType {
  preventive,
  corrective;

  String get label {
    switch (this) {
      case WorkOrderType.preventive:
        return 'PM';
      case WorkOrderType.corrective:
        return 'EM';
    }
  }
}

enum WorkOrderStatus {
  pending,
  inProgress,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case WorkOrderStatus.pending:
        return 'Pending';
      case WorkOrderStatus.inProgress:
        return 'In Progress';
      case WorkOrderStatus.completed:
        return 'Completed';
      case WorkOrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

enum WorkOrderPriority {
  low,
  medium,
  high,
  critical;

  String get label {
    switch (this) {
      case WorkOrderPriority.low:
        return 'Low';
      case WorkOrderPriority.medium:
        return 'Medium';
      case WorkOrderPriority.high:
        return 'High';
      case WorkOrderPriority.critical:
        return 'Critical';
    }
  }
}

class MaintenanceWorkOrder {
  final String id;
  final String equipment;
  final String title;
  final WorkOrderType type;
  final WorkOrderStatus status;
  final WorkOrderPriority priority;
  final String requester;
  final String assignedTo;
  final DateTime createdAt;

  const MaintenanceWorkOrder({
    required this.id,
    required this.equipment,
    required this.title,
    required this.type,
    required this.status,
    required this.priority,
    required this.requester,
    required this.assignedTo,
    required this.createdAt,
  });
}
