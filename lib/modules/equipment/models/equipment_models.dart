import 'package:flutter/material.dart';

class Equipment {
  final String id;
  final String code;
  final String name;
  final String type;
  final String location;
  final String manufacturer;
  final String model;
  final EquipmentStatus status;
  final double mtbf;
  final double mttr;

  const Equipment({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.location,
    required this.manufacturer,
    required this.model,
    required this.status,
    required this.mtbf,
    required this.mttr,
  });

  String get statusLabel {
    switch (status) {
      case EquipmentStatus.operational:
        return 'در حال کار';
      case EquipmentStatus.stopped:
        return 'متوقف';
      case EquipmentStatus.maintenance:
        return 'در تعمیرات';
      case EquipmentStatus.outOfService:
        return 'خارج از سرویس';
    }
  }

  Color get statusColor {
    switch (status) {
      case EquipmentStatus.operational:
        return Colors.green;
      case EquipmentStatus.stopped:
        return Colors.orange;
      case EquipmentStatus.maintenance:
        return Colors.blue;
      case EquipmentStatus.outOfService:
        return Colors.red;
    }
  }
}

enum EquipmentStatus {
  operational,
  stopped,
  maintenance,
  outOfService,
}
