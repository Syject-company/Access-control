import 'package:json_annotation/json_annotation.dart';

part 'update_language_request_model.g.dart';

@JsonSerializable()
class UpdateLanguageRequestModel {
  UpdateLanguageRequestModel({
    required this.lang,
  });

  factory UpdateLanguageRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateLanguageRequestModelFromJson(json);

  final String lang;

  Map<String, dynamic> toJson() => _$UpdateLanguageRequestModelToJson(this);
}
