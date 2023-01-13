import 'package:json_annotation/json_annotation.dart';
part 'classification_model.g.dart';

@JsonSerializable()
class ClassificationModel {
  ClassificationModel({
    required this.id,
    required this.code,
    required this.externalId,
  });

  factory ClassificationModel.fromJson(Map<String, dynamic> json) =>
      _$ClassificationModelFromJson(json);

  final int? id;
  final String? code;
  final String? externalId;

  Map<String, dynamic> toJson() => _$ClassificationModelToJson(this);
}
