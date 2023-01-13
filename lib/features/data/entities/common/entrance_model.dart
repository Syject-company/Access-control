import 'package:json_annotation/json_annotation.dart';

part 'entrance_model.g.dart';

@JsonSerializable()
class EntranceModel {
  EntranceModel({
    required this.id,
    required this.name,
    required this.floorId,
    required this.createUserId,
    required this.updateUserId,
    required this.createDate,
    required this.updateDate,
  });

  factory EntranceModel.fromJson(Map<String, dynamic> json) =>
      _$EntranceModelFromJson(json);

  final int? id;
  final String? name;
  final int? floorId;
  final int? createUserId;
  final int? updateUserId;
  final DateTime? createDate;
  final DateTime? updateDate;

  Map<String, dynamic> toJson() => _$EntranceModelToJson(this);
}
