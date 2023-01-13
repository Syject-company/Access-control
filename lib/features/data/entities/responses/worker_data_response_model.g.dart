// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_data_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerDataResponseModel _$WorkerDataResponseModelFromJson(
        Map<String, dynamic> json) =>
    WorkerDataResponseModel(
      id: json['id'] as int,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
      project: json['project'] == null
          ? null
          : ProjectWorkerModel.fromJson(
              json['project'] as Map<String, dynamic>),
      person: json['person'] == null
          ? null
          : PersonWorkerModel.fromJson(json['person'] as Map<String, dynamic>),
      classification: json['classification'] == null
          ? null
          : ClassificationModel.fromJson(
              json['classification'] as Map<String, dynamic>),
      position: json['position'] == null
          ? null
          : PositionWorkerModel.fromJson(
              json['position'] as Map<String, dynamic>),
      identificationNumber: json['identificationNumber'] as String?,
      firstName: json['firstName'] as String?,
      surname: json['surname'] as String?,
      image: json['image'] == null
          ? null
          : ImagePersonModel.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkerDataResponseModelToJson(
        WorkerDataResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'identificationNumber': instance.identificationNumber,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'image': instance.image,
      'person': instance.person,
      'project': instance.project,
      'classification': instance.classification,
      'position': instance.position,
    };
