import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';

part 'user_data_response_model.g.dart';

@JsonSerializable()
class UserDataResponseModel {
  const UserDataResponseModel({
    required this.id,
    required this.username,
    required this.language,
    required this.permissions,
    required this.projects,
  });

  factory UserDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseModelFromJson(json);

  final int? id;
  final String? username;
  final String? language;
  final List<int>? permissions;
  final List<ProjectResponseModel>? projects;

  Map<String, dynamic> toJson() => _$UserDataResponseModelToJson(this);
}
