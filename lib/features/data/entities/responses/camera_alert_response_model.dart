import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/alert_details_model.dart';

part 'camera_alert_response_model.g.dart';

@JsonSerializable()
class CameraAlertResponseModel {
  CameraAlertResponseModel({
    required this.id,
    required this.createDate,
    required this.cameraId,
    required this.statusDes,
    required this.alertDetails,
    required this.updateDate,
    required this.alertDetailsId,
    required this.status,
  });

  factory CameraAlertResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CameraAlertResponseModelFromJson(json);

  final int? id;
  final DateTime? createDate;
  final DateTime? updateDate;
  @JsonKey(name: 'hardwareIdentifier')
  final String? cameraId;
  @JsonKey(name: 'statusDescription')
  final String? statusDes;
  final int? alertDetailsId;
  final int? status;
  final AlertDetailsModel? alertDetails;

  Map<String, dynamic> toJson() => _$CameraAlertResponseModelToJson(this);
}
