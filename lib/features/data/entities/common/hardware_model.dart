import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/building_model.dart';
import 'package:safe_access/features/data/entities/common/entrance_model.dart';
import 'package:safe_access/features/data/entities/common/floor_model.dart';

part 'hardware_model.g.dart';

@JsonSerializable()
class HardwareModel {
  HardwareModel({
    required this.id,
    required this.identifier,
    required this.projectId,
    required this.buildingId,
    required this.floorId,
    required this.entranceId,
    required this.directionId,
    required this.locationDesc,
    required this.monitoringStatusId,
    required this.building,
    required this.floor,
    required this.entrance,
    required this.updateDate ,
    required this.createDate ,
    required this.model ,
    required this.serialNumber ,
  });

  factory HardwareModel.fromJson(Map<String, dynamic> json) =>
      _$HardwareModelFromJson(json);

  final int? id;
  final String? identifier;
  final int? projectId;
  final int? buildingId;
  final int? floorId;
  final int? entranceId;
  final int? directionId;
  final String? locationDesc;
  final int? monitoringStatusId;
  final String? serialNumber;
  final DateTime? createDate;
  final DateTime? updateDate;
  final String? model;
  final BuildingModel? building;
  final FloorModel? floor;
  final EntranceModel? entrance;

  Map<String, dynamic> toJson() => _$HardwareModelToJson(this);
}
