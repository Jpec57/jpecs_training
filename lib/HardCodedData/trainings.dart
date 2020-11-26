import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Models/ExerciseSet.dart';
import 'package:jpec_training/Models/Training.dart';

Future<List<Training>> loadChestTrainings() {
  List<Training> chestTrainings = [];
  Training chestTraining =
      new Training(id: 1, name: "Santouryuu Chest", exercises: [
    new Exercise(
        name: "Chest Fly",
        sets: createStandardExerciseSet(6, 15, 25, weight: 20)),
    new Exercise(
        name: "Declined Push Ups", sets: createStandardExerciseSet(6, 20, 25)),
    new Exercise(
        name: "Wide Push Ups", sets: createStandardExerciseSet(6, 20, 25)),
    //
    new Exercise(name: "Dips", sets: createStandardExerciseSet(5, 15, 25)),
    new Exercise(
        name: "Pike Push Ups", sets: createStandardExerciseSet(5, 10, 25)),
    new Exercise(
        name: "Pseudo Push Ups", sets: createStandardExerciseSet(5, 10, 25)),
    //
    new Exercise(
        name: "Triceps extension", sets: createStandardExerciseSet(6, 20, 25)),
    new Exercise(
        name: "Close Push Ups", sets: createStandardExerciseSet(6, 15, 25)),
    new Exercise(
        name: "Chest Fly + Wide Push Ups",
        sets: createStandardExerciseSet(6, 10, 25)),
  ]);
  chestTrainings.add(chestTraining);
  chestTraining = new Training(id: 2, name: "PecTriceps", exercises: [
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
        sets: createStandardExerciseSet(6, 20, 25),
        isHold: true),
  ]);
  chestTrainings.add(chestTraining);
  chestTraining.id = 3;
  chestTrainings.add(chestTraining);
  chestTraining.id = 4;
  chestTrainings.add(chestTraining);
  return Future.value(chestTrainings);
}

Future<List<Training>> loadShouldersTrainings() {
  List<Training> trainings = [];
  Training training =
      new Training(id: 5, name: "Don't raise your hand", exercises: [
    new Exercise(
        name: "Pike Push Ups", sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Hindu Push Ups", sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Pseudo Push Ups", sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Military Press", sets: createStandardExerciseSet(4, 10, 60)),
    new Exercise(
        name: "To Chin Elevation", sets: createStandardExerciseSet(4, 10, 60)),
    new Exercise(
        name: "Frontal Elevation", sets: createStandardExerciseSet(5, 10, 60)),
    new Exercise(
        name: "Lateral Elevation", sets: createStandardExerciseSet(5, 10, 60)),
    new Exercise(
        name: "Pseudo Planche Leans",
        sets: createStandardExerciseSet(6, 15, 25),
        isHold: true),
  ]);
  trainings.add(training);
  training = new Training(id: 6, name: "Test Shoulders", exercises: [
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
  trainings.add(training);
  return Future.value(trainings);
}

Future<List<Training>> loadBackTrainings() {
  List<Training> backTrainings = [];
  Training backTraining = new Training(id: 7, name: "FL Training", exercises: [
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

Future<List<Training>> loadAbsTrainings() {
  List<Training> trainings = [];
  Training training = new Training(name: "Test abs", exercises: [
    new Exercise(
        name: "Squat hold",
        sets: createStandardExerciseSet(2, 10, 60),
        isHold: true),
    new Exercise(name: "Squat", sets: createStandardExerciseSet(3, 10, 60))
  ]);
  trainings.add(training);
  return Future.value(trainings);
}

Future<List<Training>> loadLegTrainings() {
  List<Training> legsTrainings = [];
  Training legTraining = new Training(name: "Test leg", exercises: [
    new Exercise(
        name: "Squat hold",
        sets: createStandardExerciseSet(2, 10, 60),
        restAfter: 90,
        isHold: true),
    new Exercise(name: "Squat", sets: createStandardExerciseSet(3, 10, 60))
  ]);
  legsTrainings.add(legTraining);
  return Future.value(legsTrainings);
}
