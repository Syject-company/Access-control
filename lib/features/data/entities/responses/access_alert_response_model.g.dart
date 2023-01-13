// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_alert_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessAlertResponseModel _$AccessAlertResponseModelFromJson(
        Map<String, dynamic> json) =>
    AccessAlertResponseModel(
      id: json['id'] as int?,
      alertType: json['alertType'] as String?,
      classificationId: json['classificationId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
      alertDetailsId: json['alertDetailsId'] as int?,
      personId: json['personId'] as int?,
      alertDetails: json['alertDetails'] == null
          ? null
          : AlertDetailsModel.fromJson(
              json['alertDetails'] as Map<String, dynamic>),
      updateUserId: json['updateUserId'] as int?,
      createUserId: json['createUserId'] as int?,
      handledByUserId: json['handledByUserId'] as int?,
      imageId: json['imageId'] as int?,
      isFirstAppearance: json['isFirstAppearance'] as bool?,
      personsProjectsId: json['personsProjectsId'] as int?,
      person: json['person'] == null
          ? null
          : PersonWorkerModel.fromJson(json['person'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : ImagePersonModel.fromJson(json['image'] as Map<String, dynamic>),
      personsProjects: json['personsProjects'] == null
          ? null
          : PersonsProjectsModel.fromJson(
              json['personsProjects'] as Map<String, dynamic>),
      project: json['project'] == null
          ? null
          : ProjectModel.fromJson(json['project'] as Map<String, dynamic>),
      projectId: json['projectId'] as int?,
      classifications: json['classifications'] == null
          ? null
          : ClassificationModel.fromJson(
              json['classifications'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$AccessAlertResponseModelToJson(
        AccessAlertResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'createUserId': instance.createUserId,
      'updateUserId': instance.updateUserId,
      'handledByUserId': instance.handledByUserId,
      'alertType': instance.alertType,
      'personId': instance.personId,
      'classificationId': instance.classificationId,
      'alertDetailsId': instance.alertDetailsId,
      'imageId': instance.imageId,
      'personsProjectsId': instance.personsProjectsId,
      'isFirstAppearance': instance.isFirstAppearance,
      'alertDetails': instance.alertDetails,
      'image': instance.image,
      'personsProjects': instance.personsProjects,
      'person': instance.person,
      'classifications': instance.classifications,
      'projectId': instance.projectId,
      'project': instance.project,
    };
