import 'package:json_annotation/json_annotation.dart';
part 'Author.g.dart';

@JsonSerializable()
class Author{
  String loginname;
  @JsonKey(name: 'avatar_url')
  String avatarUrl;
  Author(this.loginname, this.avatarUrl);

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}