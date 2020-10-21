import 'package:json_annotation/json_annotation.dart';
import 'ExerciseSet.dart';

part 'Exercise.g.dart';

@JsonSerializable()
class Exercise {
  String name;
  String description;
  String img;
  List<String> requiredMaterial;
  bool isHold;
  List<ExerciseSet> sets;

  Exercise({this.name, this.description, this.img, this.requiredMaterial,
    this.isHold, this.sets});

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}