// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handle_access_alert_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HandleAccessAlertRequestModel _$HandleAccessAlertRequestModelFromJson(
        Map<String, dynamic> json) =>
    HandleAccessAlertRequestModel(
      alertId: json['alertId'] as int,
      alertType: json['alertType'] as String,
    );

Map<String, dynamic> _$HandleAccessAlertRequestModelToJson(
        HandleAccessAlertRequestModel instance) =>
    <String, dynamic>{
      'alertId': instance.alertId,
      'alertType': instance.alertType,
    };
