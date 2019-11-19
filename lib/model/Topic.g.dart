// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
      json['id'] as String,
      json['author_id'] as String,
      json['tab'] as String,
      json['content'] as String,
      json['title'] as String,
      json['good'] as bool,
      json['top'] as bool,
      json['reply_count'] as int,
      json['visit_count'] as int,
      json['create_at'] as String,
      json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      (json['replies'] as List)
          ?.map((e) =>
              e == null ? null : Reply.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['is_collect'] as bool)
    ..lastReplyAt = json['last_reply_at'] as String;
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'tab': instance.tab,
      'content': instance.content,
      'title': instance.title,
      'last_reply_at': instance.lastReplyAt,
      'good': instance.good,
      'top': instance.top,
      'reply_count': instance.replyCount,
      'visit_count': instance.visitCount,
      'create_at': instance.createAt,
      'author': instance.author,
      'replies': instance.replies,
      'is_collect': instance.isCollect
    };
