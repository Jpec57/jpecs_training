import 'package:flutter/material.dart';
import 'package:jpec_training/Models/NamedExerciseSet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TrainingData.g.dart';

@JsonSerializable()
class TrainingData {
  int trainingId;
  List<List<NamedExerciseSet>> doneExercises;

  TrainingData({@required this.trainingId, this.doneExercises});

  factory TrainingData.fromJson(Map<String, dynamic> json) =>
      _$TrainingDataFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingDataToJson(this);
}
