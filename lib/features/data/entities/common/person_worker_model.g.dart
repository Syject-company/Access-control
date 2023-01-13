// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_worker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonWorkerModel _$PersonWorkerModelFromJson(Map<String, dynamic> json) =>
    PersonWorkerModel(
      id: json['id'] as int?,
      createUserId: json['createUserId'] as int?,
      updateUserId: json['updateUserId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
      personTypeId: json['personTypeId'] as int?,
      identificationTypeId: json['identificationTypeId'] as int?,
      identificationCountryId: json['identificationCountryId'] as int?,
      identificationNumber: json['identificationNumber'] as String?,
      personImageId: json['personImageId'] as int?,
      surname: json['surname'] as String?,
      firstName: json['firstName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      image: json['image'] == null
          ? null
          : ImagePersonModel.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonWorkerModelToJson(PersonWorkerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createUserId': instance.createUserId,
      'updateUserId': instance.updateUserId,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'personTypeId': instance.personTypeId,
      'identificationTypeId': instance.identificationTypeId,
      'identificationCountryId': instance.identificationCountryId,
      'identificationNumber': instance.identificationNumber,
      'personImageId': instance.personImageId,
      'surname': instance.surname,
      'firstName': instance.firstName,
      'dateOfBirth': instance.dateOfBirth,
      'image': instance.image,
    };
