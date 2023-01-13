// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorModel _$FloorModelFromJson(Map<String, dynamic> json) => FloorModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      buildingId: json['buildingId'] as int?,
      createUserId: json['createUserId'] as int?,
      updateUserId: json['updateUserId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$FloorModelToJson(FloorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'buildingId': instance.buildingId,
      'createUserId': instance.createUserId,
      'updateUserId': instance.updateUserId,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
    };
