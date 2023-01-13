// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_assign_to_project_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerAssignToProjectRequestModel _$WorkerAssignToProjectRequestModelFromJson(
        Map<String, dynamic> json) =>
    WorkerAssignToProjectRequestModel(
      projectId: json['projectId'] as int,
      personId: json['personId'] as int,
    );

Map<String, dynamic> _$WorkerAssignToProjectRequestModelToJson(
        WorkerAssignToProjectRequestModel instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'projectId': instance.projectId,
    };
