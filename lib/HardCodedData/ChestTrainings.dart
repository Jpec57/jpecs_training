import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Models/ExerciseSet.dart';
import 'package:jpec_training/Models/Training.dart';

Future<List<Training>> loadChestTrainings() {
  List<Training> chestTrainings = [];
  Training chestTraining = new Training(name: "FirstTraining", exercises: [
    new Exercise(name: "Dips", sets: createStandardExerciseSet(6, 10, 60))
  ]);
  chestTrainings.add(chestTraining);
  return Future.value(chestTrainings);
}
