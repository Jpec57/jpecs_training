import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Models/NamedExerciseSet.dart';
import 'package:jpec_training/Models/TrainingData.dart';
import 'package:jpec_training/Pages/HomePage/HomePage.dart';
import 'package:jpec_training/Services/TrainingResultService.dart';

class TrainingResultPage extends StatefulWidget {
  static const routeName = "/training/result";
  final TrainingData trainingData;

  const TrainingResultPage({Key key, @required this.trainingData})
      : super(key: key);

  @override
  _TrainingResultPageState createState() => _TrainingResultPageState();
}

class _TrainingResultPageState extends State<TrainingResultPage>
    with SingleTickerProviderStateMixin {
  TrainingData _updatedTrainingData;
  AnimationController _scoreAnimController;
  Animation _scoreAnimation;

  @override
  void initState() {
    super.initState();
    _updatedTrainingData = widget.trainingData;
    _scoreAnimController = new AnimationController(
        vsync: this, duration: const Duration(seconds: 2));

    _scoreAnimation = IntTween(
            begin: 0,
            end: calculateWorkoutScore(_updatedTrainingData.doneExercises))
        .animate(CurvedAnimation(
            parent: _scoreAnimController, curve: Curves.easeOut))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _scoreAnimController.reverse();
            }
          });

    _scoreAnimController.animateTo(
        calculateWorkoutScore(_updatedTrainingData.doneExercises).toDouble());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _renderExerciseTile(int cycleIndex, int exerciseIndex) {
    List<NamedExerciseSet> exercises =
        _updatedTrainingData.doneExercises[cycleIndex];
    NamedExerciseSet exerciseSet = exercises[exerciseIndex];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greenArtichoke,
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "images/jpec_logo.png",
                height: 80,
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("${exerciseSet.name}", textAlign: TextAlign.center),
              )),
              Row(
                children: [
                  InkWell(
                    child: Icon(Icons.remove_circle),
                    onTap: () {
                      if (exerciseSet.repsOrDuration - 1 >= 0) {
                        setState(() {
                          exerciseSet.repsOrDuration =
                              exerciseSet.repsOrDuration - 1;
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text("${exerciseSet.repsOrDuration}"),
                  ),
                  InkWell(
                    child: Icon(Icons.add_circle),
                    onTap: () {
                      setState(() {
                        exerciseSet.repsOrDuration =
                            exerciseSet.repsOrDuration + 1;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _renderExercises() {
    List<Widget> exerciseTiles = [];

    int cycleIndex = 0;

    for (List<NamedExerciseSet> cycleExercises
        in _updatedTrainingData.doneExercises) {
      exerciseTiles.add(Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Text(
          "Cycle ${cycleIndex + 1}",
          style: TextStyle(fontFamily: 'NerkoOne', fontSize: 30),
        ),
      ));

      for (int exerciseIndex = 0;
          exerciseIndex < cycleExercises.length;
          exerciseIndex++) {
        exerciseTiles.add(_renderExerciseTile(cycleIndex, exerciseIndex));
      }

      cycleIndex++;
    }

    return exerciseTiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.charlestonGreen,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Workout result',
                      style: TextStyle(fontSize: 40, fontFamily: 'NerkoOne'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Container(
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: _scoreAnimation,
                          builder: (BuildContext context, Widget child) {
                            if (_scoreAnimController.isAnimating) {
                              return Text(
                                "${_scoreAnimation.value}",
                                style: TextStyle(fontSize: 70),
                              );
                            }
                            return Text(
                              "${calculateWorkoutScore(_updatedTrainingData.doneExercises)}",
                              style: TextStyle(fontSize: 70),
                            );
                          },
                        ),
                        Text("Points"),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  color: AppColors.beige,
                  onPressed: () {
                    Get.toNamed(HomePage.routeName);
                  },
                  child: Text(
                    "Validate".toUpperCase(),
                    style: TextStyle(
                        color: AppColors.richBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 8, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _renderExercises(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
