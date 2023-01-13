import 'package:json_annotation/json_annotation.dart';

part 'image_person_model.g.dart';

@JsonSerializable()
class ImagePersonModel {
  ImagePersonModel({required this.imgUrl});

  factory ImagePersonModel.fromJson(Map<String, dynamic> json) =>
      _$ImagePersonModelFromJson(json);

  final String? imgUrl;

  Map<String, dynamic> toJson() => _$ImagePersonModelToJson(this);
}
