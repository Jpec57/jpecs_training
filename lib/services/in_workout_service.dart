import 'package:jpec_training/models/exercise.dart';
import 'package:jpec_training/models/named_exercise_set.dart';
import 'package:jpec_training/models/training.dart';
import 'package:jpec_training/models/training_data.dart';

int getTotalSetNumber(Training training) {
  int totalSets = 0;
  int nbCycle = training.nbCycle ?? 1;

  for (Exercise exercise in training.exercises) {
    totalSets += exercise.sets.length;
  }
  return nbCycle * totalSets;
}

int getTotalDoneSetNumber(TrainingData trainingData) {
  int doneSets = 0;
  List<List<NamedExerciseSet>> doneExercisesPerCycle =
      trainingData.doneExercises;
  if (trainingData.doneExercises == null) {
    return 0;
  }
  for (List<NamedExerciseSet> cycleExercises in doneExercisesPerCycle) {
    doneSets += cycleExercises.length;
  }
  return doneSets;
}

double getPercentTrainingProgression(
    Training training, TrainingData trainingData,
    {bool beforeInsert = false}) {
  if (trainingData.doneExercises == null) {
    return 0;
  }
  int doneSets = getTotalDoneSetNumber(trainingData);
  if (beforeInsert) {
    doneSets++;
  }
  int totalSets = getTotalSetNumber(training);
  return doneSets / totalSets;
}

bool isWorkoutOver(Training training, TrainingData trainingData,
    {bool beforeInsert = false}) {
  int totalDoneSets = getTotalDoneSetNumber(trainingData);
  if (beforeInsert) {
    totalDoneSets++;
  }
  return totalDoneSets == getTotalSetNumber(training);
}

Exercise getNextExercise(
    Training training, int cycleIndex, int exerciseIndex, int setIndex) {
  var exercises = training.exercises;
  var currentExo = training.exercises[exerciseIndex];
  int nbSets = currentExo.sets.length;
  if (setIndex + 1 == nbSets) {
    setIndex = 0;
    //Changing exercise ?
    if (exerciseIndex + 1 == exercises.length) {
      exerciseIndex = 0;
      //Changing cycle ?
      int nbCycle = training.nbCycle ?? 1;
      if (cycleIndex + 1 == nbCycle) {
        //Real end, should never happen because of isWorkoutOver
        return null;
      } else {
        return training.exercises[0];
      }
    } else {
      return training.exercises[exerciseIndex + 1];
    }
  }
  return training.exercises[exerciseIndex];
}
