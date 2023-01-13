// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionResponseModel _$PositionResponseModelFromJson(
        Map<String, dynamic> json) =>
    PositionResponseModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      externalId: json['externalId'] as String?,
    );

Map<String, dynamic> _$PositionResponseModelToJson(
        PositionResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'externalId': instance.externalId,
    };
