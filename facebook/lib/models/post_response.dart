import 'package:facebook/models/location.dart';
import 'package:facebook/models/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable(
    explicitToJson: true
)

class PostResponse {
  final List<Post> data;
  final int total;
  final int page;
  final int limit;

  const PostResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });
  factory PostResponse.fromJson(Map<String, dynamic> json) => _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}