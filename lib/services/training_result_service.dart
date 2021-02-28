import 'package:jpec_training/models/named_exercise_set.dart';

int calculateWorkoutScore(List<List<NamedExerciseSet>> cycles) {
  int score = 0;
  for (List<NamedExerciseSet> exercise in cycles) {
    for (NamedExerciseSet set in exercise) {
      score += (set.repsOrDuration *
          (1 + (set.weight != null && set.weight > 0 ? 1 : 0)));
    }
  }
  return score;
}

/*
 difficulty *




  rest
  IF IS WEIGHTED :
    difficulty = BASE_EXO_DIFFICULTY * (used_weight / 1RM)
  ELSE:
    difficulty = BASE_EXO_DIFFICULTY * BODYWEIGHT_DIFFICULTY_RATIO




  BODYWEIGHT_DIFFICULTY_RATIO:

  USER_BODYWEIGHT / MEDIAN_BODYWEIGHT where MEDIAN_BODYWEIGHT is calculated
   based on the user's height and the influence of the physical shape estimate (muscular => lowering the IMC, skinny, fat...)

 */
