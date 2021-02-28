// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseSet _$ExerciseSetFromJson(Map<String, dynamic> json) {
  return ExerciseSet(
    repsOrDuration: json['repsOrDuration'] as int,
    rest: json['rest'] as int,
    weight: json['weight'] as int,
  );
}

Map<String, dynamic> _$ExerciseSetToJson(ExerciseSet instance) =>
    <String, dynamic>{
      'repsOrDuration': instance.repsOrDuration,
      'rest': instance.rest,
      'weight': instance.weight,
    };
