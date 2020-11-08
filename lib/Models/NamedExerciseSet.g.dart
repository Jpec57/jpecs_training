// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NamedExerciseSet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamedExerciseSet _$NamedExerciseSetFromJson(Map<String, dynamic> json) {
  return NamedExerciseSet(
    name: json['name'] as String,
    repsOrDuration: json['repsOrDuration'] as int,
    rest: json['rest'] as int,
    weight: json['weight'] as int,
  );
}

Map<String, dynamic> _$NamedExerciseSetToJson(NamedExerciseSet instance) =>
    <String, dynamic>{
      'name': instance.name,
      'repsOrDuration': instance.repsOrDuration,
      'rest': instance.rest,
      'weight': instance.weight,
    };
