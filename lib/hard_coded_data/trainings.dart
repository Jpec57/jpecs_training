import 'package:jpec_training/models/exercise.dart';
import 'package:jpec_training/models/exercise_set.dart';
import 'package:jpec_training/models/training.dart';

Future<List<Training>> loadChestTrainings() {
  List<Training> chestTrainings = [];

  Training jpec = new Training(id: 57, name: "TRICEPS", exercises: [
    new Exercise(name: "Dips", sets: createStandardExerciseSet(6, 25, 25)),
    new Exercise(
        name: "Inclined Push Ups", sets: createStandardExerciseSet(6, 25, 25)),
    new Exercise(
        name: "Declined Push Ups",
        sets: createStandardExerciseSet(6, 25, 25),
        restAfter: 60),
    new Exercise(
        name: "Wall Triceps Extension",
        sets: createStandardExerciseSet(4, 20, 25)),
    new Exercise(
        name: "Floor Triceps Extension",
        sets: createStandardExerciseSet(4, 20, 25)),
    new Exercise(
        name: "Elastic Triceps Extension",
        sets: createStandardExerciseSet(4, 20, 25)),
    new Exercise(name: "Dips", sets: createStandardExerciseSet(1, 50, 25)),
  ]);
  chestTrainings.add(jpec);

  Training lafay = new Training(id: 57, name: "Lafay", exercises: [
    new Exercise(name: "Dips", sets: createStandardExerciseSet(6, 30, 25)),
    new Exercise(
        name: "Inclined Push Ups", sets: createStandardExerciseSet(6, 30, 25)),
    new Exercise(
        name: "Declined Push Ups", sets: createStandardExerciseSet(6, 30, 25)),
    new Exercise(
        name: "Wide Pull Ups", sets: createStandardExerciseSet(6, 6, 25)),
    new Exercise(name: "Pull Ups", sets: createStandardExerciseSet(6, 8, 25)),
    new Exercise(
        name: "Pike Push Ups", sets: createStandardExerciseSet(3, 12, 25)),
    new Exercise(
        name: "Triceps Extension", sets: createStandardExerciseSet(3, 20, 25)),
    new Exercise(
        name: "Wide Pull Ups", sets: createStandardExerciseSet(1, 20, 25)),
    new Exercise(name: "Dips", sets: createStandardExerciseSet(1, 50, 25)),
  ]);
  chestTrainings.add(lafay);

  Training chestTraining = new Training(
      id: 0,
      name: "Haki",
      nbCycle: 10,
      restBetweenCycle: 60,
      exercises: [
        new Exercise(
            name: "Wide Pull Ups",
            sets: [new ExerciseSet(repsOrDuration: 15, rest: 25)]),
        new Exercise(
            name: "Dips",
            sets: [new ExerciseSet(repsOrDuration: 40, rest: 60)]),
        //
        new Exercise(
            name: "Regular Pull Ups",
            sets: [new ExerciseSet(repsOrDuration: 10, rest: 5)]),
        new Exercise(
            name: "Australian Pull Ups",
            sets: [new ExerciseSet(repsOrDuration: 20, rest: 25)]),
        //
        new Exercise(
            name: "Dips",
            sets: [new ExerciseSet(repsOrDuration: 40, rest: 25)]),
        new Exercise(
            name: "Diamond Push Ups",
            sets: [new ExerciseSet(repsOrDuration: 20, rest: 25)]),
        //
        new Exercise(
            name: "Chin Ups",
            sets: [new ExerciseSet(repsOrDuration: 10, rest: 25)]),
        new Exercise(
            name: "Triceps Extension",
            sets: [new ExerciseSet(repsOrDuration: 20, rest: 60)]),
      ]);
  chestTrainings.add(chestTraining);

  chestTraining = new Training(id: 1, name: "Santouryuu Chest", exercises: [
    new Exercise(
        name: "Chest Fly",
        sets: createStandardExerciseSet(6, 15, 25, weight: 20)),
    new Exercise(
        name: "Declined Push Ups", sets: createStandardExerciseSet(6, 20, 25)),
    new Exercise(
        name: "Wide Push Ups",
        sets: createStandardExerciseSet(6, 25, 25),
        restAfter: 60),
    //
    new Exercise(name: "Dips", sets: createStandardExerciseSet(6, 15, 25)),
    new Exercise(
        name: "Pseudo Push Ups", sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Pike Push Ups",
        sets: createStandardExerciseSet(6, 10, 25),
        restAfter: 60),
    new Exercise(
        name: "Hindu Push Ups",
        sets: createStandardExerciseSet(4, 10, 25),
        restAfter: 60),
    //
    new Exercise(
        name: "Triceps extension", sets: createStandardExerciseSet(6, 20, 25)),
    new Exercise(
        name: "Close Push Ups", sets: createStandardExerciseSet(6, 15, 25)),
    new Exercise(
        name: "Chest Fly + Wide Push Ups",
        sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Wide Push Ups", sets: createStandardExerciseSet(6, 25, 25)),
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
  chestTraining = new Training(id: 5, name: "Yonkô Chest", exercises: [
    new Exercise(
        name: "Chest Fly",
        sets: createStandardExerciseSet(6, 20, 25, weight: 20),
        restAfter: 60),
    new Exercise(
        name: "Pike Push Ups", sets: createStandardExerciseSet(6, 15, 25)),
    new Exercise(
        name: "Declined Push Ups", sets: createStandardExerciseSet(6, 20, 25)),
    new Exercise(
        name: "Slow Dips",
        sets: createStandardExerciseSet(6, 15, 25),
        restAfter: 60),
    //
    new Exercise(
      name: "Wide Push Ups (slow/quick)",
      sets: createStandardExerciseSet(6, 10, 25),
    ),
    new Exercise(
        name: "Slow Wide Dips", sets: createStandardExerciseSet(6, 15, 25)),
    new Exercise(
        name: "Close Push Ups",
        sets: createStandardExerciseSet(6, 15, 25),
        restAfter: 60),
    //
    new Exercise(
        name: "Triceps extension (floor)",
        sets: createStandardExerciseSet(6, 10, 25)),
    new Exercise(
        name: "Triceps extension (weighted)",
        sets: createStandardExerciseSet(6, 10, 25, weight: 30)),
    new Exercise(
        name: "Triceps extension (gum)",
        sets: createStandardExerciseSet(6, 10, 25)),
    //
    new Exercise(
        name: "Pike Push Ups", sets: createStandardExerciseSet(3, 10, 60)),
    new Exercise(
        name: "Hold Wide Push Up Position",
        sets: createStandardExerciseSet(1, 20, 3),
        isHold: true),
    new Exercise(
        name: "Wide Push Ups on Time",
        sets: createStandardExerciseSet(1, 40, 25),
        isHold: true),
    new Exercise(
        name: "Hold Wide Push Up Position",
        sets: createStandardExerciseSet(1, 20, 3),
        isHold: true),
    new Exercise(
        name: "Wide Push Ups on Time",
        sets: createStandardExerciseSet(1, 40, 25),
        isHold: true),
    new Exercise(
        name: "Hold Wide Push Up Position",
        sets: createStandardExerciseSet(1, 20, 3),
        isHold: true),
    new Exercise(
        name: "Wide Push Ups on Time",
        sets: createStandardExerciseSet(1, 40, 25),
        isHold: true),
  ]);
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
  Training training = new Training(name: "V-Sit Hunt", exercises: [
    new Exercise(
        name: "V-Sit",
        sets: createStandardExerciseSet(4, 20, 60),
        isHold: true
    ),
    new Exercise(
        name: "L-to-V Sit Raises",
        sets: createStandardExerciseSet(4, 10, 60),
        isHold: false
    ),
    new Exercise(
        name: "V-Sit",
        sets: createStandardExerciseSet(4, 20, 60),
        isHold: true
    ),
    new Exercise(
        name: "Floor Leg Raises",
        sets: createStandardExerciseSet(4, 10, 30),
        isHold: false
    ),
    //
    new Exercise(
        name: "Star Fish Abs",
        sets: createStandardExerciseSet(5, 30, 25),
        isHold: false
    ),
    new Exercise(
        name: "Toe Touches",
        sets: createStandardExerciseSet(5, 20, 20),
        isHold: false
    ),
    new Exercise(
        name: "Bicycle Abs",
        sets: createStandardExerciseSet(5, 50, 15),
        isHold: false
    ),
    new Exercise(
        name: "Plank",
        sets: createStandardExerciseSet(1, 500, 5),
        isHold: true
    ),
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
