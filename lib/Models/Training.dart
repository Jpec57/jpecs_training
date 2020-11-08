import 'package:jpec_training/Models/Exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Training.g.dart';

@JsonSerializable(nullable: false)
class Training {
  String name;
  int authorId;
  int nbCycle = 1;
  int restBetweenCycle = 60;
  String lastTime;
  String coverImg;
  List<Exercise> exercises;

  Training(
      {this.name,
      this.authorId,
      this.coverImg,
      this.exercises,
      this.lastTime,
      this.restBetweenCycle,
      this.nbCycle});
  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingToJson(this);
}
