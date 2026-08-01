class EquipmentPart {
  final String id;
  final String equipmentId;
  final String sparePartId;
  final double requiredQuantity;

  const EquipmentPart({
    required this.id,
    required this.equipmentId,
    required this.sparePartId,
    required this.requiredQuantity,
  });
}

const List<EquipmentPart> equipmentPartMockData = [
  EquipmentPart(
    id: 'BOM-001',
    equipmentId: 'EQ-001',
    sparePartId: 'SP-001',
    requiredQuantity: 2,
  ),
  EquipmentPart(
    id: 'BOM-002',
    equipmentId: 'EQ-001',
    sparePartId: 'SP-002',
    requiredQuantity: 1,
  ),
  EquipmentPart(
    id: 'BOM-003',
    equipmentId: 'EQ-002',
    sparePartId: 'SP-003',
    requiredQuantity: 4,
  ),
  EquipmentPart(
    id: 'BOM-004',
    equipmentId: 'EQ-003',
    sparePartId: 'SP-001',
    requiredQuantity: 2,
  ),
  EquipmentPart(
    id: 'BOM-005',
    equipmentId: 'EQ-004',
    sparePartId: 'SP-004',
    requiredQuantity: 1,
  ),
];
