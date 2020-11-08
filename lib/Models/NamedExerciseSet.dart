import 'package:json_annotation/json_annotation.dart';

part 'NamedExerciseSet.g.dart';

@JsonSerializable()
class NamedExerciseSet {
  String name;
  int repsOrDuration;
  int rest;
  int weight;

  NamedExerciseSet({this.name, this.repsOrDuration, this.rest, this.weight});

  factory NamedExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$NamedExerciseSetFromJson(json);
  Map<String, dynamic> toJson() => _$NamedExerciseSetToJson(this);
}