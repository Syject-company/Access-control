import 'package:json_annotation/json_annotation.dart';

part 'firebase_token_request_model.g.dart';

@JsonSerializable()
class FirebaseTokenRequestModel {
  FirebaseTokenRequestModel({
    required this.deviceId,
    required this.fcmToken,
    required this.isDelete,
  });

  factory FirebaseTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseTokenRequestModelFromJson(json);
  final String deviceId;
  final String fcmToken;
  final bool isDelete;

  Map<String, dynamic> toJson() => _$FirebaseTokenRequestModelToJson(this);
}
