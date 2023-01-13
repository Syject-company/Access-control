// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectResponseModel _$ProjectResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProjectResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$ProjectResponseModelToJson(
        ProjectResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'isActive': instance.isActive,
    };
