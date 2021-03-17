import 'package:flutter/cupertino.dart';
import 'package:jpec_training/models/exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training.g.dart';

@JsonSerializable(nullable: false)
class Training {
  int id;
  String name;
  int? authorId;
  int nbCycle = 1;
  int? restBetweenCycle = 60;
  String? lastTime;
  String? coverImg;
  List<Exercise> exercises;

  Training(
      {required this.id,
      required this.name,
      this.authorId,
      this.coverImg,
      required this.exercises,
      this.lastTime,
      this.restBetweenCycle,
      required this.nbCycle});
  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingToJson(this);
}
