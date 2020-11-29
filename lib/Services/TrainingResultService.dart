import 'package:jpec_training/Models/NamedExerciseSet.dart';

int calculateWorkoutScore(List<List<NamedExerciseSet>> cycles) {
  int score = 0;
  for (var cycle in cycles) {
    for (var exercise in cycle) {
      score += (exercise.repsOrDuration *
          (1 + (exercise.weight != null && exercise.weight > 0 ? 1 : 0)));
    }
  }
  return score;
}
