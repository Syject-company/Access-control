import 'package:json_annotation/json_annotation.dart';

part 'building_model.g.dart';

@JsonSerializable()
class BuildingModel {
  BuildingModel({
    required this.id,
    required this.name,
    required this.projectId,
    required this.createUserId,
    required this.updateUserId,
    required this.createDate,
    required this.updateDate,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingModelFromJson(json);

  final int? id;
  final String? name;
  final int? projectId;
  final int? createUserId;
  final int? updateUserId;
  final DateTime? createDate;
  final DateTime? updateDate;

  Map<String, dynamic> toJson() => _$BuildingModelToJson(this);
}
