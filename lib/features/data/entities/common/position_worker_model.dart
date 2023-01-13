import 'package:json_annotation/json_annotation.dart';

part 'position_worker_model.g.dart';

@JsonSerializable()
class PositionWorkerModel {
  PositionWorkerModel({
    required this.id,
    required this.createDate,
    required this.externalId,
    required this.updateDate,
    required this.name,
  });

  factory PositionWorkerModel.fromJson(Map<String, dynamic> json) =>
      _$PositionWorkerModelFromJson(json);

  final int? id;
  final DateTime? createDate;
  final DateTime? updateDate;
  final String? externalId;
  final String? name;

  Map<String, dynamic> toJson() => _$PositionWorkerModelToJson(this);
}
