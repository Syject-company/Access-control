// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_alert_search_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessAlertSearchRequestModel _$AccessAlertSearchRequestModelFromJson(
        Map<String, dynamic> json) =>
    AccessAlertSearchRequestModel(
      identificationNumber: json['identificationNumber'] as String?,
      toDate: json['toDate'] as String,
      fromDate: json['fromDate'] as String,
      classification: (json['classification'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      projectId: json['projectId'] as int,
      handled: json['handled'] as bool?,
      active: json['active'] as bool?,
      offset: json['offset'] as int,
    );

Map<String, dynamic> _$AccessAlertSearchRequestModelToJson(
    AccessAlertSearchRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('classification', instance.classification);
  val['toDate'] = instance.toDate;
  val['fromDate'] = instance.fromDate;
  writeNotNull('active', instance.active);
  writeNotNull('handled', instance.handled);
  writeNotNull('identificationNumber', instance.identificationNumber);
  val['projectId'] = instance.projectId;
  val['offset'] = instance.offset;
  return val;
}
