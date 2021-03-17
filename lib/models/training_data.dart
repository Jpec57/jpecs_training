import 'package:flutter/material.dart';
import 'package:jpec_training/models/named_exercise_set.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training_data.g.dart';

@JsonSerializable()
class TrainingData {
  int trainingId;
  List<List<NamedExerciseSet>> doneExercises;

  TrainingData({required this.trainingId, required this.doneExercises});

  factory TrainingData.fromJson(Map<String, dynamic> json) =>
      _$TrainingDataFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingDataToJson(this);

  @override
  String toString() {
    return 'TrainingData{trainingId: $trainingId, doneExercises: $doneExercises}';
  }
}
