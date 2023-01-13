// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertDetailsModel _$AlertDetailsModelFromJson(Map<String, dynamic> json) =>
    AlertDetailsModel(
      id: json['id'] as int?,
      hardwareId: json['hardwareId'] as int?,
      projectId: json['projectId'] as int?,
      project: json['project'] == null
          ? null
          : ProjectModel.fromJson(json['project'] as Map<String, dynamic>),
      hardware: json['hardware'] == null
          ? null
          : HardwareModel.fromJson(json['hardware'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlertDetailsModelToJson(AlertDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hardwareId': instance.hardwareId,
      'projectId': instance.projectId,
      'project': instance.project,
      'hardware': instance.hardware,
    };
