// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(json['loginname'] as String, json['avatar_url'] as String,
      json['create_at'] as String, json['score'] as int);
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'loginname': instance.loginname,
      'avatar_url': instance.avatarUrl,
      'create_at': instance.createAt,
      'score': instance.score
    };
