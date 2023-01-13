import 'package:json_annotation/json_annotation.dart';

part 'employer_model.g.dart';

@JsonSerializable()
class EmployerModel {
  EmployerModel({
    required this.id,
    required this.name,
    required this.externalId,
  });

  factory EmployerModel.fromJson(Map<String, dynamic> json) =>
      _$EmployerModelFromJson(json);

  final int? id;
  final String? name;
  final String? externalId;

  Map<String, dynamic> toJson() => _$EmployerModelToJson(this);
}
