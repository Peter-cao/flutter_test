import 'package:json_annotation/json_annotation.dart';
import 'Author.dart';
import 'Reply.dart';
part 'Topic.g.dart';

@JsonSerializable()
class Topic{
  String id;
  @JsonKey(name: 'author_id')
  String authorId;
  String tab;
  String content;
  String title;
  @JsonKey(name: 'last_reply_at')
  String lastReplyAt;
  bool good;
  bool top;
  @JsonKey(name: 'reply_count')
  int replyCount;
  @JsonKey(name: 'visit_count')
  int visitCount;
  @JsonKey(name: 'create_at')
  String createAt;
  Author author;
  List<Reply> replies;
  Topic(this.id, this.authorId, this.tab, this.content, this.title, this.good, this.top, this.replyCount, this.visitCount, this.createAt, this.author, this.replies);
  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}