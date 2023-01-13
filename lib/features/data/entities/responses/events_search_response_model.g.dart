// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_search_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsSearchResponseModel _$EventsSearchResponseModelFromJson(
        Map<String, dynamic> json) =>
    EventsSearchResponseModel(
      id: json['id'] as int,
      alertType: json['alertType'] as String?,
      personsProjects: json['personsProjects'] == null
          ? null
          : PersonsProjectsModel.fromJson(
              json['personsProjects'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : ImagePersonModel.fromJson(json['image'] as Map<String, dynamic>),
      alertDetails: json['alertDetails'] == null
          ? null
          : AlertDetailsModel.fromJson(
              json['alertDetails'] as Map<String, dynamic>),
      personsProjectsId: json['personsProjectsId'] as int?,
      isFirstAppearance: json['isFirstAppearance'] as bool?,
      handledByUserId: json['handledByUserId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      classifications: json['classifications'] == null
          ? null
          : ClassificationSearchWorkerModel.fromJson(
              json['classifications'] as Map<String, dynamic>),
      person: json['person'] == null
          ? null
          : PersonWorkerModel.fromJson(json['person'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$EventsSearchResponseModelToJson(
        EventsSearchResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate?.toIso8601String(),
      'handledByUserId': instance.handledByUserId,
      'alertType': instance.alertType,
      'personsProjectsId': instance.personsProjectsId,
      'isFirstAppearance': instance.isFirstAppearance,
      'comment': instance.comment,
      'image': instance.image,
      'personsProjects': instance.personsProjects,
      'alertDetails': instance.alertDetails,
      'classifications': instance.classifications,
      'person': instance.person,
    };
