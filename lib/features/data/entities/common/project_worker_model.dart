import 'package:json_annotation/json_annotation.dart';

part 'project_worker_model.g.dart';

@JsonSerializable()
class ProjectWorkerModel {
  ProjectWorkerModel({
    required this.id,
    required this.name,
    required this.code,
    required this.isActive,
    required this.createDate,
    required this.updateDate,
  });

  factory ProjectWorkerModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectWorkerModelFromJson(json);

  final int? id;
  final String? name;
  final String? code;
  final bool? isActive;
  final DateTime? createDate;
  final DateTime? updateDate;

  Map<String, dynamic> toJson() => _$ProjectWorkerModelToJson(this);
}
