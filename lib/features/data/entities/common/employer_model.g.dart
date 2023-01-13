// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployerModel _$EmployerModelFromJson(Map<String, dynamic> json) =>
    EmployerModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      externalId: json['externalId'] as String?,
    );

Map<String, dynamic> _$EmployerModelToJson(EmployerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'externalId': instance.externalId,
    };
