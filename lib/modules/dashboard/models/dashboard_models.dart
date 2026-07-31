class DashboardKpi {
  final String title;
  final String value;
  final String subtitle;
  final DashboardKpiStatus status;

  const DashboardKpi({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.status,
  });
}

enum DashboardKpiStatus {
  normal,
  warning,
  critical,
}

class EquipmentStatusSummary {
  final int running;
  final int stopped;
  final int underMaintenance;
  final int critical;

  const EquipmentStatusSummary({
    required this.running,
    required this.stopped,
    required this.underMaintenance,
    required this.critical,
  });

  int get total =>
      running + stopped + underMaintenance + critical;
}

class MaintenanceRequest {
  final String requestNo;
  final String equipment;
  final String description;
  final String priority;
  final String status;

  const MaintenanceRequest({
    required this.requestNo,
    required this.equipment,
    required this.description,
    required this.priority,
    required this.status,
  });
}

class DashboardData {
  final List<DashboardKpi> kpis;
  final EquipmentStatusSummary equipmentStatus;
  final String mtbf;
  final String mttr;
  final String availability;
  final String pmCompliance;
  final List<MaintenanceRequest> recentRequests;

  const DashboardData({
    required this.kpis,
    required this.equipmentStatus,
    required this.mtbf,
    required this.mttr,
    required this.availability,
    required this.pmCompliance,
    required this.recentRequests,
  });
}
