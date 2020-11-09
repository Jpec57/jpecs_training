// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NamedExerciseSet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamedExerciseSet _$NamedExerciseSetFromJson(Map<String, dynamic> json) {
  return NamedExerciseSet(
    exerciseId: json['exerciseId'] as int,
    name: json['name'] as String,
    repsOrDuration: json['repsOrDuration'] as int,
    rest: json['rest'] as int,
    weight: json['weight'] as int,
  );
}

Map<String, dynamic> _$NamedExerciseSetToJson(NamedExerciseSet instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'name': instance.name,
      'repsOrDuration': instance.repsOrDuration,
      'rest': instance.rest,
      'weight': instance.weight,
    };
