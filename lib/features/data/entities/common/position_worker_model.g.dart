// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_worker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionWorkerModel _$PositionWorkerModelFromJson(Map<String, dynamic> json) =>
    PositionWorkerModel(
      id: json['id'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      externalId: json['externalId'] as String?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PositionWorkerModelToJson(
        PositionWorkerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'externalId': instance.externalId,
      'name': instance.name,
    };
