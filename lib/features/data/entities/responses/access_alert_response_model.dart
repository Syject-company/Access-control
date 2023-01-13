import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/alert_details_model.dart';
import 'package:safe_access/features/data/entities/common/classification_model.dart';
import 'package:safe_access/features/data/entities/common/image_person_model.dart';
import 'package:safe_access/features/data/entities/common/person_worker_model.dart';
import 'package:safe_access/features/data/entities/common/persons_projects_model.dart';
import 'package:safe_access/features/data/entities/common/project_model.dart';

part 'access_alert_response_model.g.dart';

@JsonSerializable()
class AccessAlertResponseModel {
  AccessAlertResponseModel({
    required this.id,
    required this.alertType,
    required this.classificationId,
    required this.createDate,
    required this.updateDate,
    required this.alertDetailsId,
    required this.personId,
    required this.alertDetails,
    required this.updateUserId,
    required this.createUserId,
    required this.handledByUserId,
    required this.imageId,
    required this.isFirstAppearance,
    required this.personsProjectsId,
    required this.person,
    required this.image,
    required this.personsProjects,
    required this.project,
    required this.projectId,
    required this.classifications,
    required this.comment,
  });

  factory AccessAlertResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AccessAlertResponseModelFromJson(json);

  final int? id;
  final String? comment;
  final DateTime? createDate;
  final DateTime? updateDate;
  final int? createUserId;
  final int? updateUserId;
  final int? handledByUserId;
  final String? alertType;
  final int? personId;
  final int? classificationId;
  final int? alertDetailsId;
  final int? imageId;
  final int? personsProjectsId;
  final bool? isFirstAppearance;
  final AlertDetailsModel? alertDetails;
  final ImagePersonModel? image;
  final PersonsProjectsModel? personsProjects;
  final PersonWorkerModel? person;
  final ClassificationModel? classifications;
  final int? projectId;
  final ProjectModel?
      project; //Note: will in response only if the alertType is "Pending" (projectId - project)

  Map<String, dynamic> toJson() => _$AccessAlertResponseModelToJson(this);
}
