// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_alert_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CameraAlertResponseModel _$CameraAlertResponseModelFromJson(
        Map<String, dynamic> json) =>
    CameraAlertResponseModel(
      id: json['id'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      cameraId: json['hardwareIdentifier'] as String?,
      statusDes: json['statusDescription'] as String?,
      alertDetails: json['alertDetails'] == null
          ? null
          : AlertDetailsModel.fromJson(
              json['alertDetails'] as Map<String, dynamic>),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
      alertDetailsId: json['alertDetailsId'] as int?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$CameraAlertResponseModelToJson(
        CameraAlertResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'hardwareIdentifier': instance.cameraId,
      'statusDescription': instance.statusDes,
      'alertDetailsId': instance.alertDetailsId,
      'status': instance.status,
      'alertDetails': instance.alertDetails,
    };
