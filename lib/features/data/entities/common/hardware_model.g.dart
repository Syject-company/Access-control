// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardware_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HardwareModel _$HardwareModelFromJson(Map<String, dynamic> json) =>
    HardwareModel(
      id: json['id'] as int?,
      identifier: json['identifier'] as String?,
      projectId: json['projectId'] as int?,
      buildingId: json['buildingId'] as int?,
      floorId: json['floorId'] as int?,
      entranceId: json['entranceId'] as int?,
      directionId: json['directionId'] as int?,
      locationDesc: json['locationDesc'] as String?,
      monitoringStatusId: json['monitoringStatusId'] as int?,
      building: json['building'] == null
          ? null
          : BuildingModel.fromJson(json['building'] as Map<String, dynamic>),
      floor: json['floor'] == null
          ? null
          : FloorModel.fromJson(json['floor'] as Map<String, dynamic>),
      entrance: json['entrance'] == null
          ? null
          : EntranceModel.fromJson(json['entrance'] as Map<String, dynamic>),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      model: json['model'] as String?,
      serialNumber: json['serialNumber'] as String?,
    );

Map<String, dynamic> _$HardwareModelToJson(HardwareModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identifier': instance.identifier,
      'projectId': instance.projectId,
      'buildingId': instance.buildingId,
      'floorId': instance.floorId,
      'entranceId': instance.entranceId,
      'directionId': instance.directionId,
      'locationDesc': instance.locationDesc,
      'monitoringStatusId': instance.monitoringStatusId,
      'serialNumber': instance.serialNumber,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'model': instance.model,
      'building': instance.building,
      'floor': instance.floor,
      'entrance': instance.entrance,
    };
