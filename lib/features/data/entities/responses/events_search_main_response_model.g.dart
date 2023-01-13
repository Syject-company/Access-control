// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_search_main_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsSearchMainResponseModel _$EventsSearchMainResponseModelFromJson(
        Map<String, dynamic> json) =>
    EventsSearchMainResponseModel(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) =>
              EventsSearchResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventsSearchMainResponseModelToJson(
        EventsSearchMainResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
