import 'package:json_annotation/json_annotation.dart';

part 'classification_search_worker_model.g.dart';

@JsonSerializable()
class ClassificationSearchWorkerModel {
  ClassificationSearchWorkerModel({required this.id,required this.code,});
  factory ClassificationSearchWorkerModel.fromJson(Map<String, dynamic> json) =>
      _$ClassificationSearchWorkerModelFromJson(json);
  final int? id;
  final String? code;
  Map<String, dynamic> toJson() => _$ClassificationSearchWorkerModelToJson(this);
}