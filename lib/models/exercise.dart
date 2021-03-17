import 'package:flutter/cupertino.dart';
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
  int executionTime;
  List<ExerciseSet> sets;
  int? restAfter;

  Exercise(
      {required this.id,
      required this.name,
      required this.description,
      this.img,
      this.requiredMaterial = const [],
      this.isHold = false,
      this.executionTime = CONCENTRIC,
      required this.sets,
      this.restAfter});

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
