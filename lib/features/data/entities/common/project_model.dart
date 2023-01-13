import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

@JsonSerializable()
class ProjectModel {
  ProjectModel({
    required this.id,
    required this.name,
    required this.code,
    required this.isActive,
    required this.createUserId,
    required this.updateUserId,
    required this.createDate,
    required this.updateDate,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  final int? id;
  final String? name;
  final String? code;
  final bool? isActive;
  final int? createUserId;
  final int? updateUserId;
  final DateTime? createDate;
  final DateTime? updateDate;

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}
