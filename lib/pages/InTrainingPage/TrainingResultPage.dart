import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/models/NamedExerciseSet.dart';
import 'package:jpec_training/models/TrainingData.dart';
import 'package:jpec_training/pages/HomePage/HomePage.dart';
import 'package:jpec_training/services/TrainingResultService.dart';

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
    _expandedExercises = _isExerciseExpandedList();
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

  List<List<bool>> _isExerciseExpandedList() {
    List<List<bool>> groupedCycleExercises = [];

    for (List<NamedExerciseSet> cycleSets
        in _updatedTrainingData.doneExercises) {
      int nbSetsInCycle = cycleSets.length;

      List<bool> groupedExercises = [];

      //Regrouping same exercise together
      int setInCycleIndex = 0;
      while (setInCycleIndex < nbSetsInCycle) {
        int firstIndex = setInCycleIndex;
        while (setInCycleIndex < nbSetsInCycle &&
            cycleSets[setInCycleIndex].name == cycleSets[firstIndex].name) {
          setInCycleIndex++;
        }
        groupedExercises.add(false);
      }
      //END
      groupedCycleExercises.add(groupedExercises);
    }
    return groupedCycleExercises;
  }

  @override
  void dispose() {
    _scoreAnimController.dispose();
    super.dispose();
  }

  _generateExerciseExpansionPanelChildren(
      int cycleIndex, List<List<NamedExerciseSet>> cycleExercises) {
    List<ExpansionPanel> children = [];
    int exerciseIndexInCycle = 0;
    for (var sameExerciseSets in cycleExercises) {
      List<Widget> _tiles = [];
      int totalReps = 0;
      double averageReps = 0;
      int nbSets = sameExerciseSets.length;
      int exerciseSetIndex = 0;
      for (NamedExerciseSet set in sameExerciseSets) {
        totalReps += set.repsOrDuration;
        _tiles.add(Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Text(
                'Set ${exerciseSetIndex + 1}${set.weight != null ? "@${set.weight}" : ""}: ',
                style: TextStyle(color: Colors.black),
              ),
              InkWell(
                child: Icon(Icons.remove_circle),
                onTap: () {
                  if (set.repsOrDuration > 0) {
                    setState(() {
                      set.repsOrDuration = set.repsOrDuration - 1;
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text("${set.repsOrDuration}",
                    style: TextStyle(color: Colors.black)),
              ),
              InkWell(
                child: Icon(Icons.add_circle),
                onTap: () {
                  setState(() {
                    set.repsOrDuration = set.repsOrDuration + 1;
                  });
                },
              ),
              Spacer(),
            ],
          ),
        ));
        exerciseSetIndex++;
      }
      averageReps = (totalReps / nbSets).toPrecision(1);

      children.add(ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Container(
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
                    child: Text("${sameExerciseSets[0].name}",
                        textAlign: TextAlign.center),
                  )),
                  Text(
                    'Avg $averageReps',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
        isExpanded: _expandedExercises[cycleIndex][exerciseIndexInCycle],
        body: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.beige,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8, left: 15, right: 15),
              child: Column(
                children: _tiles,
              ),
            ),
          ),
        ),
      ));
      exerciseIndexInCycle++;
    }
    return children;
  }

  Widget _renderCycleExercises(
      List<List<NamedExerciseSet>> cycleExercises, int cycleIndex) {
    return ClipRRect(
      child: Theme(
        data: Theme.of(context),
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _expandedExercises[cycleIndex][index] =
                  !_expandedExercises[cycleIndex][index];
            });
          },
          children: _generateExerciseExpansionPanelChildren(
              cycleIndex, cycleExercises),
        ),
      ),
    );
  }

  List<Widget> _renderCycleWidgets() {
    List<Widget> cycleTiles = [];

    int cycleIndex = 0;

    for (List<NamedExerciseSet> cycleSets
        in _updatedTrainingData.doneExercises) {
      int nbSetsInCycle = cycleSets.length;
      List<List<NamedExerciseSet>> groupedExercises = [];

      //Regrouping same exercise together
      int setInCycleIndex = 0;
      while (setInCycleIndex < nbSetsInCycle) {
        List<NamedExerciseSet> sameExerciseSets = [];
        int firstIndex = setInCycleIndex;
        while (setInCycleIndex < nbSetsInCycle &&
            cycleSets[setInCycleIndex].name == cycleSets[firstIndex].name) {
          sameExerciseSets.add(cycleSets[setInCycleIndex]);
          setInCycleIndex++;
        }
        groupedExercises.add(sameExerciseSets);
      }
      //END
      cycleTiles.add(Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                "Cycle ${cycleIndex + 1}",
                style: TextStyle(fontFamily: 'NerkoOne', fontSize: 30),
              ),
            ),
            _renderCycleExercises(groupedExercises, cycleIndex)
          ],
        ),
      ));
      cycleIndex++;
    }

    return cycleTiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                    mainAxisSize: MainAxisSize.min,
                    children: _renderCycleWidgets(),
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

/*
  List<List<List<NamedExerciseSet>>> _buildFormattedExerciseList() {
    List<List<List<NamedExerciseSet>>> groupedCycleExercises = [];

    for (List<NamedExerciseSet> cycleSets
        in _updatedTrainingData.doneExercises) {
      int nbSetsInCycle = cycleSets.length;

      List<List<NamedExerciseSet>> groupedExercises = [];

      //Regrouping same exercise together
      int setInCycleIndex = 0;
      while (setInCycleIndex < nbSetsInCycle) {
        List<NamedExerciseSet> sameExerciseSets = [];
        int firstIndex = setInCycleIndex;
        while (setInCycleIndex < nbSetsInCycle &&
            cycleSets[setInCycleIndex].name == cycleSets[firstIndex].name) {
          sameExerciseSets.add(cycleSets[setInCycleIndex]);
          setInCycleIndex++;
        }
        groupedExercises.add(sameExerciseSets);
      }
      //END
      groupedCycleExercises.add(groupedExercises);
    }
    return groupedCycleExercises;
  }

 */
