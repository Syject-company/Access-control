import 'package:json_annotation/json_annotation.dart';

part 'project_response_model.g.dart';

@JsonSerializable()
class ProjectResponseModel {
  ProjectResponseModel({
    required this.id,
    required this.name,
    required this.code,
    required this.isActive,
  });

  factory ProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseModelFromJson(json);

  final int id;
  final String name;
  final String code;
  final bool isActive;

  Map<String, dynamic> toJson() => _$ProjectResponseModelToJson(this);
}
