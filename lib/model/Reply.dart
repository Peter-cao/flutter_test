import 'package:json_annotation/json_annotation.dart';
import 'Author.dart';
part 'Reply.g.dart';

@JsonSerializable()
class Reply{
  String id;
  Author author;
  String content;
  List<String> ups;
   @JsonKey(name: 'create_at')
  String createAt;
  @JsonKey(name: 'reply_id')
  String replyId;
  @JsonKey(name: 'is_uped')
  bool isUped;
  Reply(this.id, this.author, this.content, this.ups, this.createAt, this.replyId, this.isUped);
  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}