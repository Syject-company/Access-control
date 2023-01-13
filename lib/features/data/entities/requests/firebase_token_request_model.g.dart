// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_token_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseTokenRequestModel _$FirebaseTokenRequestModelFromJson(
        Map<String, dynamic> json) =>
    FirebaseTokenRequestModel(
      deviceId: json['deviceId'] as String,
      fcmToken: json['fcmToken'] as String,
      isDelete: json['isDelete'] as bool,
    );

Map<String, dynamic> _$FirebaseTokenRequestModelToJson(
        FirebaseTokenRequestModel instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'fcmToken': instance.fcmToken,
      'isDelete': instance.isDelete,
    };
