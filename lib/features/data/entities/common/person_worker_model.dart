import 'package:json_annotation/json_annotation.dart';
import 'package:safe_access/features/data/entities/common/image_person_model.dart';

part 'person_worker_model.g.dart';

@JsonSerializable()
class PersonWorkerModel {
  PersonWorkerModel({
    required this.id,
    required this.createUserId,
    required this.updateUserId,
    required this.createDate,
    required this.updateDate,
    required this.personTypeId,
    required this.identificationTypeId,
    required this.identificationCountryId,
    required this.identificationNumber,
    required this.personImageId,
    required this.surname,
    required this.firstName,
    required this.dateOfBirth,
    required this.image,
  });

  factory PersonWorkerModel.fromJson(Map<String, dynamic> json) =>
      _$PersonWorkerModelFromJson(json);

final int? id;
  final int? createUserId;
  final int? updateUserId;
  final DateTime? createDate;
  final DateTime? updateDate;
  final int? personTypeId;
  final int? identificationTypeId;
  final int? identificationCountryId;
  final String? identificationNumber;
  final int? personImageId;
  final String? surname;
  final String? firstName;
  final String? dateOfBirth;
  final ImagePersonModel? image;

  Map<String, dynamic> toJson() => _$PersonWorkerModelToJson(this);
}
