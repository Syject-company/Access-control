import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/hardware_model.dart';
import 'package:safe_access/features/data/entities/common/project_model.dart';

part 'alert_details_model.g.dart';

@JsonSerializable()
class AlertDetailsModel {
  AlertDetailsModel({
    required this.id,
    required this.hardwareId,
    required this.projectId,
    required this.project,
    required this.hardware,
  });

  factory AlertDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AlertDetailsModelFromJson(json);

  final int? id;
  final int? hardwareId;
  final int? projectId;
  final ProjectModel? project;
  final HardwareModel? hardware;

  Map<String, dynamic> toJson() => _$AlertDetailsModelToJson(this);
}
