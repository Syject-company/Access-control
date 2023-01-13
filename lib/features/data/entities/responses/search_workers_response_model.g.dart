// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_workers_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchWorkersResponseModel _$SearchWorkersResponseModelFromJson(
        Map<String, dynamic> json) =>
    SearchWorkersResponseModel(
      id: json['id'] as int,
      surname: json['surname'] as String?,
      idNumber: json['identificationNumber'] as String?,
      firstName: json['firstName'] as String?,
      classification: json['classification'] == null
          ? null
          : ClassificationSearchWorkerModel.fromJson(
              json['classification'] as Map<String, dynamic>),
      employerId: json['employerId'] as int?,
      lastEntrance: json['lastEntrance'] == null
          ? null
          : DateTime.parse(json['lastEntrance'] as String),
      photoUrl: json['photoUrl'] as String?,
      positionId: json['positionId'] as int?,
      idType: json['identificationType'] as int?,
    );

Map<String, dynamic> _$SearchWorkersResponseModelToJson(
        SearchWorkersResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identificationNumber': instance.idNumber,
      'identificationType': instance.idType,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'photoUrl': instance.photoUrl,
      'lastEntrance': instance.lastEntrance?.toIso8601String(),
      'classification': instance.classification,
      'employerId': instance.employerId,
      'positionId': instance.positionId,
    };
