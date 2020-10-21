// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Training.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Training _$TrainingFromJson(Map<String, dynamic> json) {
  return Training(
    name: json['name'] as String,
    authorId: json['authorId'] as int,
    coverImg: json['coverImg'] as String,
    exercises: (json['exercises'] as List)
        .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TrainingToJson(Training instance) => <String, dynamic>{
      'name': instance.name,
      'authorId': instance.authorId,
      'coverImg': instance.coverImg,
      'exercises': instance.exercises,
    };
