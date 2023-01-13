import 'package:json_annotation/json_annotation.dart';

part 'position_response_model.g.dart';

@JsonSerializable()
class PositionResponseModel {
  PositionResponseModel({
    required this.id,
    required this.name,
    required this.externalId,
  });

  factory PositionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PositionResponseModelFromJson(json);

  final int id;
  final String? name;
  final String? externalId;

  Map<String, dynamic> toJson() => _$PositionResponseModelToJson(this);
}
