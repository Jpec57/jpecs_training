import 'package:json_annotation/json_annotation.dart';

part 'ExerciseSet.g.dart';


@JsonSerializable()
class ExerciseSet {
  int repsOrDuration;
  int rest;

  ExerciseSet({this.repsOrDuration, this.rest});

  factory ExerciseSet.fromJson(Map<String, dynamic> json) => _$ExerciseSetFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseSetToJson(this);
}