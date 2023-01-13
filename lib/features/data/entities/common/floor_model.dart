import 'package:json_annotation/json_annotation.dart';

part 'floor_model.g.dart';

@JsonSerializable()
class FloorModel {
  FloorModel({
    required this.id,
    required this.name,
    required this.buildingId,
    required this.createUserId,
    required this.updateUserId,
    required this.createDate,
    required this.updateDate,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);

  final int? id;
  final String? name;
  final int? buildingId;
  final int? createUserId;
  final int? updateUserId;
  final DateTime? createDate;
  final DateTime? updateDate;

  Map<String, dynamic> toJson() => _$FloorModelToJson(this);
}
