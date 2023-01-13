import 'package:json_annotation/json_annotation.dart';

part 'handle_access_alert_request_model.g.dart';

@JsonSerializable()
class HandleAccessAlertRequestModel {
  HandleAccessAlertRequestModel({
    required this.alertId,
    required this.alertType,
  });

  factory HandleAccessAlertRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HandleAccessAlertRequestModelFromJson(json);
  final int alertId;
  final String alertType;

  Map<String, dynamic> toJson() => _$HandleAccessAlertRequestModelToJson(this);
}
