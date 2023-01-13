// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntranceModel _$EntranceModelFromJson(Map<String, dynamic> json) =>
    EntranceModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      floorId: json['floorId'] as int?,
      createUserId: json['createUserId'] as int?,
      updateUserId: json['updateUserId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$EntranceModelToJson(EntranceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'floorId': instance.floorId,
      'createUserId': instance.createUserId,
      'updateUserId': instance.updateUserId,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
    };
