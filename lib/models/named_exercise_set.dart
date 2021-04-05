import 'package:json_annotation/json_annotation.dart';

part 'named_exercise_set.g.dart';

@JsonSerializable()
class NamedExerciseSet {
  int exerciseId;
  String name;
  int repsOrDuration;
  int rest;
  int? weight;

  NamedExerciseSet(
      {required this.exerciseId,
      required this.name,
      required this.repsOrDuration,
      required this.rest,
      required this.weight});

  factory NamedExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$NamedExerciseSetFromJson(json);
  Map<String, dynamic> toJson() => _$NamedExerciseSetToJson(this);

  @override
  String toString() {
    return 'NamedExerciseSet{exerciseId: $exerciseId, name: $name, repsOrDuration: $repsOrDuration, rest: $rest, weight: $weight}';
  }
}
