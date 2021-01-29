// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return Exercise(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    img: json['img'] as String,
    requiredMaterial:
        (json['requiredMaterial'] as List)?.map((e) => e as String)?.toList(),
    isHold: json['isHold'] as bool,
    sets: (json['sets'] as List)
        ?.map((e) =>
            e == null ? null : ExerciseSet.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    restAfter: json['restAfter'] as int,
  );
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'img': instance.img,
      'requiredMaterial': instance.requiredMaterial,
      'isHold': instance.isHold,
      'sets': instance.sets,
      'restAfter': instance.restAfter,
    };
