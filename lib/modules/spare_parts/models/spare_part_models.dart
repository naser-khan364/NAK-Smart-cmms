enum SparePartCriticality {
  low,
  medium,
  high,
  critical,
}

class SparePart {
  final String id;
  final String code;
  final String name;
  final String unit;
  final double quantity;
  final SparePartCriticality criticality;
  final double minimumStock;

  const SparePart({
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.criticality,
    required this.minimumStock,
  });

  bool get isBelowMinimum => quantity < minimumStock;
}
