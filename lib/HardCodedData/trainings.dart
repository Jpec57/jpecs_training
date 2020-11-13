import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Models/ExerciseSet.dart';
import 'package:jpec_training/Models/Training.dart';

Future<List<Training>> loadChestTrainings() {
  List<Training> chestTrainings = [];
  Training chestTraining = new Training(name: "PecPec", exercises: [
    new Exercise(name: "Push Ups", sets: createStandardExerciseSet(3, 10, 60)),
    new Exercise(name: "Dips", sets: createStandardExerciseSet(3, 10, 60))
  ]);
  chestTrainings.add(chestTraining);
  chestTraining = new Training(name: "PecTriceps", exercises: [
    new Exercise(
        name: "Triceps extension", sets: createStandardExerciseSet(6, 15, 25)),
    new Exercise(
        name: "Close Push Ups", sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Declined Push Ups", sets: createStandardExerciseSet(6, 20, 25)),
    new Exercise(
        name: "Wide Push Ups", sets: createStandardExerciseSet(6, 20, 25)),
    new Exercise(name: "Dips", sets: createStandardExerciseSet(6, 20, 25)),
    new Exercise(
        name: "Pike Push Ups", sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Pseudo Planche Leans",
        sets: createStandardExerciseSet(6, 15, 25),
        isHold: true),
  ]);
  chestTrainings.add(chestTraining);
  return Future.value(chestTrainings);
}

Future<List<Training>> loadBackTrainings() {
  List<Training> backTrainings = [];
  Training backTraining = new Training(name: "FL Training", exercises: [
    new Exercise(
        name: "Assisted Front Lever (orange)",
        sets: createStandardExerciseSet(6, 10, 60),
        isHold: true),
    new Exercise(
        name: "Assisted Front Lever (red)",
        sets: createStandardExerciseSet(6, 15, 45),
        isHold: true),
    new Exercise(
        name: "Assisted Front Lever (black)",
        sets: createStandardExerciseSet(6, 20, 25),
        isHold: true),
    new Exercise(
        name: "Front Lever Pull Ups",
        sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Bird + Rowing", sets: createStandardExerciseSet(5, 10, 25)),
    new Exercise(
        name: "Kettlebell", sets: createStandardExerciseSet(6, 20, 25)),
    //Biceps
    new Exercise(
        name: "Curl Barre", sets: createStandardExerciseSet(6, 10, 60)),
    new Exercise(name: "Curl", sets: createStandardExerciseSet(4, 10, 60)),
    new Exercise(name: "Pull Ups", sets: createStandardExerciseSet(6, 10, 25)),
  ]);
  backTrainings.add(backTraining);
  return Future.value(backTrainings);
}

Future<List<Training>> loadLegTrainings() {
  List<Training> legsTrainings = [];
  Training legTraining = new Training(name: "FirstTraining", exercises: [
    new Exercise(
        name: "Squat hold",
        sets: createStandardExerciseSet(2, 10, 60),
        isHold: true),
    new Exercise(name: "Squat", sets: createStandardExerciseSet(3, 10, 60))
  ]);
  legsTrainings.add(legTraining);
  return Future.value(legsTrainings);
}
