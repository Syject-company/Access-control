// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persons_projects_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonsProjectsModel _$PersonsProjectsModelFromJson(
        Map<String, dynamic> json) =>
    PersonsProjectsModel(
      position: json['position'] == null
          ? null
          : PositionWorkerModel.fromJson(
              json['position'] as Map<String, dynamic>),
      employer: json['employer'] == null
          ? null
          : EmployerModel.fromJson(json['employer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonsProjectsModelToJson(
        PersonsProjectsModel instance) =>
    <String, dynamic>{
      'employer': instance.employer,
      'position': instance.position,
    };
