import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ExerciseSet.g.dart';

@JsonSerializable()
class ExerciseSet {
  int repsOrDuration;
  int rest;
  int weight;

  ExerciseSet(
      {@required this.repsOrDuration, @required this.rest, this.weight});

  factory ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseSetToJson(this);
}

List<ExerciseSet> createStandardExerciseSet(int setNumber, int reps, int rest) {
  List<ExerciseSet> sets = [];
  for (int i = 0; i < setNumber; i++) {
    sets.add(new ExerciseSet(repsOrDuration: reps, rest: rest));
  }
  return sets;
}
