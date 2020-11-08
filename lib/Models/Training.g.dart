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
    lastTime: json['lastTime'] as String,
    restBetweenCycle: json['restBetweenCycle'] as int,
    nbCycle: json['nbCycle'] as int,
  );
}

Map<String, dynamic> _$TrainingToJson(Training instance) => <String, dynamic>{
      'name': instance.name,
      'authorId': instance.authorId,
      'nbCycle': instance.nbCycle,
      'restBetweenCycle': instance.restBetweenCycle,
      'lastTime': instance.lastTime,
      'coverImg': instance.coverImg,
      'exercises': instance.exercises,
    };
