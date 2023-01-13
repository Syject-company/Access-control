// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_worker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectWorkerModel _$ProjectWorkerModelFromJson(Map<String, dynamic> json) =>
    ProjectWorkerModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      isActive: json['isActive'] as bool?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$ProjectWorkerModelToJson(ProjectWorkerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'isActive': instance.isActive,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
    };
