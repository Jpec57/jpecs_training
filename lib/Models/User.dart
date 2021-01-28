import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String username;

  User({this.id, this.username});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id}';
  }

  @override
  List<Object> get props => [id, username];
}
