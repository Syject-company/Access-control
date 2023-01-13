import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/classification_model.dart';
import 'package:safe_access/features/data/entities/common/image_person_model.dart';
import 'package:safe_access/features/data/entities/common/person_worker_model.dart';
import 'package:safe_access/features/data/entities/common/position_worker_model.dart';
import 'package:safe_access/features/data/entities/common/project_worker_model.dart';

part 'worker_data_response_model.g.dart';

@JsonSerializable()
class WorkerDataResponseModel {
  WorkerDataResponseModel({
    required this.id,
    required this.createDate,
    required this.updateDate,
    required this.project,
    required this.person,
    required this.classification,
    required this.position,
    required this.identificationNumber,
    required this.firstName,
    required this.surname,
    required this.image,
  });

  factory WorkerDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerDataResponseModelFromJson(json);

  final int id;
  final DateTime? createDate;
  final DateTime? updateDate;
  final String? identificationNumber;
  final String? firstName;
  final String? surname;
  final ImagePersonModel? image;
  final PersonWorkerModel? person;
  final ProjectWorkerModel? project;
  final ClassificationModel? classification;
  final PositionWorkerModel? position;

  Map<String, dynamic> toJson() => _$WorkerDataResponseModelToJson(this);
}
