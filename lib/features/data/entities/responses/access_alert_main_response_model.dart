import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';

part 'access_alert_main_response_model.g.dart';

@JsonSerializable()
class AccessAlertMainResponseModel {
  AccessAlertMainResponseModel({
    required this.count,
    required this.rows,
  });

  factory AccessAlertMainResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AccessAlertMainResponseModelFromJson(json);

  final int? count;
  final List<AccessAlertResponseModel>? rows;

  Map<String, dynamic> toJson() => _$AccessAlertMainResponseModelToJson(this);
}
