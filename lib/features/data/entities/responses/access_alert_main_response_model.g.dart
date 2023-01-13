// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_alert_main_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessAlertMainResponseModel _$AccessAlertMainResponseModelFromJson(
        Map<String, dynamic> json) =>
    AccessAlertMainResponseModel(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) =>
              AccessAlertResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccessAlertMainResponseModelToJson(
        AccessAlertMainResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
