import 'package:json_annotation/json_annotation.dart';

part 'access_alert_search_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class AccessAlertSearchRequestModel {
  AccessAlertSearchRequestModel({
    this.identificationNumber,
    required this.toDate,
    required this.fromDate,
    this.classification,
    required this.projectId,
    this.handled,
    this.active,
    required this.offset,
  });

  factory AccessAlertSearchRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AccessAlertSearchRequestModelFromJson(json);

  final List<int>? classification;

  final String toDate;
  final String fromDate;
  final bool? active;
  final bool? handled;
  final String? identificationNumber;
  final int projectId;
  final int offset;

  Map<String, dynamic> toJson() => _$AccessAlertSearchRequestModelToJson(this);
}
