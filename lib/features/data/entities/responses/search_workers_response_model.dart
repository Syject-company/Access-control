import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/classification_search_worker_model.dart';

part 'search_workers_response_model.g.dart';

@JsonSerializable()
class SearchWorkersResponseModel {
  SearchWorkersResponseModel({
    required this.id,
    required this.surname,
    required this.idNumber,
    required this.firstName,
    required this.classification,
    required this.employerId,
    required this.lastEntrance,
    required this.photoUrl,
    required this.positionId,
    required this.idType,
  });

  factory SearchWorkersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchWorkersResponseModelFromJson(json);

  final int id;
  @JsonKey(name: 'identificationNumber')
  final String? idNumber;
  @JsonKey(name: 'identificationType')
  final int? idType;
  final String? firstName;
  final String? surname;
  final String? photoUrl;
  final DateTime? lastEntrance;
  final ClassificationSearchWorkerModel? classification;
  final int? employerId;
  final int? positionId;

  Map<String, dynamic> toJson() => _$SearchWorkersResponseModelToJson(this);
}
