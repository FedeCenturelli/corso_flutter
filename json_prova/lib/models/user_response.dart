import 'package:json_prova/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable(
  explicitToJson: true
)

class UserResponse {
  final List<User> users;
  final int total;
  final dynamic skip;
  final int limit;


  UserResponse({
    required this.limit,
    required this.skip,
    required this.total,
    required this.users
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}