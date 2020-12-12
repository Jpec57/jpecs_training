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
  List<List<bool>> _expandedExercises = [];
  List<List<List<NamedExerciseSet>>> groupedExercisesPerCycle;

  @override
  void initState() {
    super.initState();
    _updatedTrainingData = widget.trainingData;
    _scoreAnimController = new AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
    groupedExercisesPerCycle = _buildFormattedExerciseList();
    _expandedExercises = [];
    for (var cycle in _updatedTrainingData.doneExercises){
      List<bool> tmpArr = [];
      for (var exo in cycle){
        tmpArr.add(false);
      }
      _expandedExercises.add(tmpArr);
    }
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


  _buildFormattedExerciseList(){
    List<List<List<NamedExerciseSet>>> groupedCycleExercises = [];
    for (List<NamedExerciseSet> cycleExercises in _updatedTrainingData.doneExercises) {
      List<List<NamedExerciseSet>> exercises = [];
      for (int exerciseIndex = 0;
      exerciseIndex < cycleExercises.length;
      exerciseIndex++) {
        List<NamedExerciseSet> sameExerciseSets = [cycleExercises[exerciseIndex]];
        int firstIndex = exerciseIndex;
        while (exerciseIndex < cycleExercises.length && cycleExercises[exerciseIndex].name == cycleExercises[firstIndex].name){
          sameExerciseSets.add(cycleExercises[exerciseIndex]);
          exerciseIndex++;
        }
        exercises.add(sameExerciseSets);
      }
      groupedCycleExercises.add(exercises);
    }
    return groupedCycleExercises;
  }

  @override
  void dispose() {
    super.dispose();
  }
  _renderCycleExercises(List<List<NamedExerciseSet>> cycleExercises, int cycleIndex){

    return ClipRRect(
      child: Theme(
        data: Theme.of(context).copyWith(cardColor: AppColors.greenArtichoke),
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _expandedExercises[cycleIndex][index] = !_expandedExercises[cycleIndex][index];
            });
          },
          children: cycleExercises.map((List<NamedExerciseSet> sameExerciseSets){
            List<Widget> _tiles = [];
            int totalReps = 0;
            double averageReps = 0;
            int nbSets = sameExerciseSets.length;
            int i = 1;
            for (NamedExerciseSet set in sameExerciseSets){
              totalReps += set.repsOrDuration;
              _tiles.add(Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Set ${i}:', style: TextStyle(color: Colors.black),),
                    InkWell(
                      child: Icon(Icons.remove_circle),
                      onTap: () {
                        if (set.repsOrDuration - 1 >= 0) {
                          setState(() {
                            set.repsOrDuration =
                                set.repsOrDuration - 1;
                          });
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text("${set.repsOrDuration}", style: TextStyle(color: Colors.black)),
                    ),
                    InkWell(
                      child: Icon(Icons.add_circle),
                      onTap: () {
                        setState(() {
                          set.repsOrDuration =
                              set.repsOrDuration + 1;
                        });
                      },
                    ),
                  ],
                ),
              ));
              i++;
            }
            averageReps = (totalReps / nbSets).toPrecision(1);

            return ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return  Container(
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
                              child: Text("${sameExerciseSets[0].name}", textAlign: TextAlign.center),
                            )),
                        Text('$averageReps Moy'),
                      ],
                    ),
                  ),
                );
              },
              isExpanded: true,
              body: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.beige,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 15),
                    child: Column(
                      children: _tiles,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Widget> _renderExercises() {
    List<Widget> cycleTiles = [];

    int cycleIndex = 0;

    for (List<NamedExerciseSet> cycleExercises
        in _updatedTrainingData.doneExercises) {
      cycleTiles.add(Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Text(
          "Cycle ${cycleIndex + 1}",
          style: TextStyle(fontFamily: 'NerkoOne', fontSize: 30),
        ),
      ));

      List<List<NamedExerciseSet>> exercises = [];

      for (int exerciseIndex = 0;
          exerciseIndex < cycleExercises.length;
          exerciseIndex++) {
        List<NamedExerciseSet> sameExerciseSets = [cycleExercises[exerciseIndex]];
        int firstIndex = exerciseIndex;
        while (exerciseIndex < cycleExercises.length && cycleExercises[exerciseIndex].name == cycleExercises[firstIndex].name){
          sameExerciseSets.add(cycleExercises[exerciseIndex]);
          exerciseIndex++;
        }
        exercises.add(sameExerciseSets);
      }
      cycleTiles.add(_renderCycleExercises(exercises, cycleIndex));
      cycleIndex++;
    }

    return cycleTiles;
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
              mainAxisSize: MainAxisSize.min,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                    mainAxisSize: MainAxisSize.max,
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
