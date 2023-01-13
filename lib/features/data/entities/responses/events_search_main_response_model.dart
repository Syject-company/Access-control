import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/responses/events_search_response_model.dart';

part 'events_search_main_response_model.g.dart';

@JsonSerializable()
class EventsSearchMainResponseModel {
  EventsSearchMainResponseModel({
    required this.count,
    required this.rows,
  });

  factory EventsSearchMainResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EventsSearchMainResponseModelFromJson(json);

  final int? count;
  final List<EventsSearchResponseModel>? rows;

  Map<String, dynamic> toJson() => _$EventsSearchMainResponseModelToJson(this);
}
