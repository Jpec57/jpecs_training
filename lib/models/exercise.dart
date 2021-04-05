import 'package:json_annotation/json_annotation.dart';

import 'exercise_set.dart';

part 'exercise.g.dart';

const ISOMETRIC = 0;
const PLYOMETRIC = 1;
const CONCENTRIC = 2;
const ECCENTRIC = 3;

@JsonSerializable()
class Exercise {
  int id;
  String name;
  String description;
  String? img;
  List<String>? requiredMaterial;
  bool isHold;
  int executionType;
  List<ExerciseSet> sets;
  int? restAfter;

  Exercise(
      {this.id = -1,
      required this.name,
      this.description = "No description",
      this.img,
      this.requiredMaterial = const [],
      this.isHold = false,
      this.executionType = CONCENTRIC,
      required this.sets,
      this.restAfter});

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
