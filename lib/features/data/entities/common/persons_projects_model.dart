import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/employer_model.dart';
import 'package:safe_access/features/data/entities/common/position_worker_model.dart';

part 'persons_projects_model.g.dart';

@JsonSerializable()
class PersonsProjectsModel {
  PersonsProjectsModel({
    required this.position,
    required this.employer,
  });

  factory PersonsProjectsModel.fromJson(Map<String, dynamic> json) =>
      _$PersonsProjectsModelFromJson(json);

  final EmployerModel? employer;

  final PositionWorkerModel? position;

  Map<String, dynamic> toJson() => _$PersonsProjectsModelToJson(this);
}
