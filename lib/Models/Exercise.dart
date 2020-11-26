import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ExerciseSet.dart';

part 'Exercise.g.dart';

@JsonSerializable()
class Exercise {
  int id;
  String name;
  String description;
  String img;
  List<String> requiredMaterial;
  bool isHold;
  List<ExerciseSet> sets;
  int restAfter;

  Exercise(
      {this.id,
      @required this.name,
      this.description,
      this.img,
      this.requiredMaterial = const [],
      this.isHold = false,
      @required this.sets,
      this.restAfter});

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
