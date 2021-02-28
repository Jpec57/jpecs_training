// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingData _$TrainingDataFromJson(Map<String, dynamic> json) {
  return TrainingData(
    trainingId: json['trainingId'] as int,
    doneExercises: (json['doneExercises'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : NamedExerciseSet.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$TrainingDataToJson(TrainingData instance) =>
    <String, dynamic>{
      'trainingId': instance.trainingId,
      'doneExercises': instance.doneExercises,
    };
