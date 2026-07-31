import 'dashboard_models.dart';

class DashboardMockData {
  static const DashboardData sample = DashboardData(
    kpis: [
      DashboardKpi(
        title: 'تجهیزات',
        value: '128',
        subtitle: 'تجهیز ثبت‌شده',
        status: DashboardKpiStatus.normal,
      ),
      DashboardKpi(
        title: 'خرابی‌های باز',
        value: '7',
        subtitle: 'نیازمند پیگیری',
        status: DashboardKpiStatus.warning,
      ),
      DashboardKpi(
        title: 'PM سررسیدشده',
        value: '12',
        subtitle: 'این هفته',
        status: DashboardKpiStatus.warning,
      ),
      DashboardKpi(
        title: 'درخواست تعمیر',
        value: '5',
        subtitle: 'در انتظار اقدام',
        status: DashboardKpiStatus.normal,
      ),
    ],
    equipmentStatus: EquipmentStatusSummary(
      running: 96,
      stopped: 14,
      underMaintenance: 13,
      critical: 5,
    ),
    mtbf: '186 h',
    mttr: '2.4 h',
    availability: '97.8%',
    pmCompliance: '92%',
    recentRequests: [
      MaintenanceRequest(
        requestNo: 'MR-1024',
        equipment: 'IGM-2200',
        description: 'افزایش دمای یاتاقان',
        priority: 'بالا',
        status: 'باز',
      ),
      MaintenanceRequest(
        requestNo: 'MR-1023',
        equipment: 'CLABO-04',
        description: 'نشتی مدار خنک‌کاری',
        priority: 'متوسط',
        status: 'در حال اقدام',
      ),
      MaintenanceRequest(
        requestNo: 'MR-1022',
        equipment: 'DRAW-08',
        description: 'صدای غیرعادی موتور',
        priority: 'بالا',
        status: 'باز',
      ),
      MaintenanceRequest(
        requestNo: 'MR-1021',
        equipment: 'PACK-03',
        description: 'اشکال در سنسور',
        priority: 'پایین',
        status: 'بسته',
      ),
    ],
  );
}
