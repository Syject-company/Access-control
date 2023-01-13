import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/alert_details_model.dart';
import 'package:safe_access/features/data/entities/common/classification_search_worker_model.dart';
import 'package:safe_access/features/data/entities/common/image_person_model.dart';
import 'package:safe_access/features/data/entities/common/person_worker_model.dart';
import 'package:safe_access/features/data/entities/common/persons_projects_model.dart';

part 'events_search_response_model.g.dart';

@JsonSerializable()
class EventsSearchResponseModel {
  EventsSearchResponseModel({
    required this.id,
    required this.alertType,
    required this.personsProjects,
    required this.image,
    required this.alertDetails,
    required this.personsProjectsId,
    required this.isFirstAppearance,
    required this.handledByUserId,
    required this.createDate,
    required this.classifications,
    required this.person,
    required this.comment,
  });

  factory EventsSearchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EventsSearchResponseModelFromJson(json);

  final int id;
  final DateTime? createDate;
  final int? handledByUserId;
  final String? alertType;
  final int? personsProjectsId;
  final bool? isFirstAppearance;
  final String? comment;
  final ImagePersonModel? image;
  final PersonsProjectsModel? personsProjects;
  final AlertDetailsModel? alertDetails;
  final ClassificationSearchWorkerModel? classifications;
  final PersonWorkerModel? person;

  Map<String, dynamic> toJson() => _$EventsSearchResponseModelToJson(this);
}