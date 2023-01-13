// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataResponseModel _$UserDataResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserDataResponseModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      language: json['language'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => ProjectResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDataResponseModelToJson(
        UserDataResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'language': instance.language,
      'permissions': instance.permissions,
      'projects': instance.projects,
    };
