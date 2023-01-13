// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingModel _$BuildingModelFromJson(Map<String, dynamic> json) =>
    BuildingModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      projectId: json['projectId'] as int?,
      createUserId: json['createUserId'] as int?,
      updateUserId: json['updateUserId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'projectId': instance.projectId,
      'createUserId': instance.createUserId,
      'updateUserId': instance.updateUserId,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
    };
