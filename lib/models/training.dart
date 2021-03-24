import 'package:jpec_training/models/exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'training.g.dart';

@JsonSerializable()
class Training {
  int id;
  String name;
  int? authorId;
  int nbCycle;
  int? restBetweenCycle;
  String? lastTime;
  String? coverImg;
  List<Exercise> exercises;

  Training(
      {this.id = -1,
      required this.name,
      this.authorId,
      this.coverImg,
      required this.exercises,
      this.lastTime,
      this.restBetweenCycle = 60,
      this.nbCycle = 1});
  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingToJson(this);
}
