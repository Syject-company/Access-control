import 'package:json_annotation/json_annotation.dart';

part 'worker_assign_to_project_request_model.g.dart';

@JsonSerializable()
class WorkerAssignToProjectRequestModel {
  WorkerAssignToProjectRequestModel({
    required this.projectId,
    required this.personId,
  });

  factory WorkerAssignToProjectRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$WorkerAssignToProjectRequestModelFromJson(json);

  final int personId;
  final int projectId;

  Map<String, dynamic> toJson() =>
      _$WorkerAssignToProjectRequestModelToJson(this);
}
