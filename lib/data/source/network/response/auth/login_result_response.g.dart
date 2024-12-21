// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResultResponse _$LoginResultResponseFromJson(Map<String, dynamic> json) =>
    LoginResultResponse(
      userId: json['userId'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginResultResponseToJson(
        LoginResultResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'token': instance.token,
    };
