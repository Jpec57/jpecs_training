import 'package:flutter/material.dart';
import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Models/ExerciseSet.dart';
import 'package:jpec_training/Models/NamedExerciseSet.dart';
import 'package:jpec_training/Models/Training.dart';
import 'package:jpec_training/Models/TrainingData.dart';
import 'package:jpec_training/Pages/HomePage/HomePage.dart';

import '../../AppColors.dart';

class InExercisePage extends StatefulWidget {
  static const routeName = "/training/exercise";
  final Training training;

  const InExercisePage({Key key, @required this.training}) : super(key: key);

  @override
  _InExercisePageState createState() => _InExercisePageState();
}

class _InExercisePageState extends State<InExercisePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TrainingData _trainingData;
  //Exercise tab
  int _currentCycle = 0;
  int _exerciseIndex = 0;
  int _setIndex = 0;
  // Timer tab
  bool _isHold = false;
  int _countdown = 49;
  int _doneReps = 18;

  List<List<NamedExerciseSet>> initDoneExercises() {
    List<List<NamedExerciseSet>> cycles = [];
    int nbCycle = widget.training.nbCycle ?? 1;
    for (int i = 0; i < nbCycle; i++) {
      cycles.add([]);
    }
    return cycles;
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _trainingData = new TrainingData(trainingId: widget.training.id);
    _trainingData.doneExercises = initDoneExercises();
  }

  @override
  void dispose() {
    super.dispose();
    _trainingData = null;
    _tabController.dispose();
  }

  Widget _renderClickableRep(int num) {
    if (num < 0) {
      return Container();
    }
    return InkWell(
        onTap: () {
          setState(() {
            _doneReps = num;
          });
        },
        child: Text("$num"));
  }

  int getTotalSetNumber() {
    int totalSets = 0;
    int nbCycle = widget.training.nbCycle ?? 1;

    for (Exercise exercise in widget.training.exercises) {
      totalSets += exercise.sets.length;
    }
    return nbCycle * totalSets;
  }

  int getTotalDoneSetNumber() {
    int doneSets = 0;
    List<List<NamedExerciseSet>> doneExercisesPerCycle =
        _trainingData.doneExercises;
    if (_trainingData.doneExercises == null) {
      return 0;
    }
    for (List<NamedExerciseSet> cycleExercises in doneExercisesPerCycle) {
      //TODO debug
      var done = [];
      for (NamedExerciseSet exerciseSet in cycleExercises) {
        done.add(exerciseSet.name);
      }
      doneSets += cycleExercises.length;
    }
    print("TOTAL DONE SETS: ${doneSets}");
    return doneSets;
  }

  double getPercentTrainingProgression() {
    if (_trainingData.doneExercises == null) {
      return 0;
    }
    int doneSets = getTotalDoneSetNumber();
    int totalSets = getTotalSetNumber();
    return doneSets / totalSets;
  }

  bool isWorkoutOver({bool beforeInsert = false}) {
    int totalDoneSets = getTotalDoneSetNumber();
    if (beforeInsert) {
      totalDoneSets++;
    }
    return totalDoneSets == getTotalSetNumber();
  }

  void switchToExerciseView() {
    List<Exercise> exercises = widget.training.exercises;
    Exercise currentExo = exercises[_exerciseIndex];
    ExerciseSet currentSet = currentExo.sets[_setIndex];
    _trainingData.doneExercises[_currentCycle].add(new NamedExerciseSet(
        name: currentExo.name,
        repsOrDuration: _doneReps,
        weight: currentSet.weight,
        rest: currentSet.rest - _countdown,
        exerciseId: currentExo.id));
    print("_trainingData.doneExercises");
    print(_trainingData.doneExercises);
    if (isWorkoutOver()) {
      Navigator.of(context).pushNamed(HomePage.routeName);
    }
    //TEST CYCLE to reset exercise index
    // if (){
    //
    // }
    setState(() {
      _tabController.index = 0;
    });
    int nbSets = currentExo.sets.length;
    if (_setIndex + 1 == nbSets) {
      _setIndex = 0;
      //Changing exercise ?
      if (_exerciseIndex + 1 == exercises.length) {
        //Changing cycle ?
        if (_currentCycle + 1 == widget.training.nbCycle) {
          //Real end, should never happen because of isWorkoutOver
          print("Fuck. End of workout.");
        } else {
          _currentCycle++;
        }
      } else {
        _exerciseIndex++;
      }
    } else {
      _setIndex++;
    }

    setState(() {});
  }

  void switchToTimerView() {
    //TODO
    //TEST if workout is over. If that is the case -> timer but no countdown to select reps num
    if (isWorkoutOver(beforeInsert: true)) {}
    setState(() {
      _tabController.index = 1;
    });
  }

  void progressInTraining() {
    List<List<NamedExerciseSet>> doneExercises = _trainingData.doneExercises;
    if (doneExercises == null) {}
  }

  Exercise getNextExercise() {
    // widget.training
    int setIndex = _setIndex;
    int exerciseIndex = _exerciseIndex;
    var exercises = widget.training.exercises;
    var currentExo = widget.training.exercises[exerciseIndex];
    int nbSets = currentExo.sets.length;
    if (setIndex + 1 == nbSets) {
      setIndex = 0;
      //Changing exercise ?
      if (exerciseIndex + 1 == exercises.length) {
        exerciseIndex = 0;
        //Changing cycle ?
        if (_currentCycle + 1 == widget.training.nbCycle) {
          //Real end, should never happen because of isWorkoutOver
          return null;
        } else {
          return widget.training.exercises[0];
        }
      } else {
        return widget.training.exercises[exerciseIndex + 1];
      }
    } else {
      return widget.training.exercises[exerciseIndex];
    }
    return null;
  }

  Widget _renderUpcomingExoNamePreview() {
    Exercise nextExo = getNextExercise();
    if (nextExo == null) {
      return Text("End of workout.");
    }
    return Text("${nextExo.name}");
  }

  Widget _renderUpcomingExoRowPreview() {
    Exercise nextExo = getNextExercise();
    if (nextExo == null) {
      return Center(child: Text("End of workout."));
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Image.asset(
            nextExo.img != null && nextExo.img.isNotEmpty
                ? nextExo.img
                : "images/jpec_logo.png",
          ),
        ),
        Flexible(
          child: Text(
            "${nextExo.description ?? ""}",
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }

  Widget _renderTimerWidget() {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.richBlack,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "Next: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _renderUpcomingExoNamePreview()
                    ],
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8.0),
                        child: _renderUpcomingExoRowPreview()),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "$_countdown",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 50),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      switchToExerciseView();
                    },
                    child: Text(
                      "SKIP",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                ],
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          color: AppColors.greenArtichoke,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                child: Text(
                  _isHold
                      ? "How long did you hold ?"
                      : "How many repetitions have you done ?",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _renderClickableRep(_doneReps - 2),
                      _renderClickableRep(_doneReps - 1),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.charlestonGreen),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$_doneReps',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                      _renderClickableRep(_doneReps + 1),
                      _renderClickableRep(_doneReps + 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _renderCurrentSetInfo() {
    String text;
    List<ExerciseSet> exoSets = widget.training.exercises[_exerciseIndex].sets;
    ExerciseSet currentSet = exoSets[_setIndex];
    if (currentSet.weight != null) {
      text = "${currentSet.repsOrDuration}r @ ${currentSet.weight}kg";
    } else {
      text = "${currentSet.repsOrDuration}r";
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50),
          ),
        ),
        exoSets.length > 1
            ? Text(
                "${_setIndex + 1} / ${exoSets.length} sets",
                style: TextStyle(
                    color: AppColors.richBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            : Container()
      ],
    );
  }

  Widget _renderExerciseTab() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.richBlack,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, left: 8, right: 8),
                    child: LinearProgressIndicator(
                      value: getPercentTrainingProgression(),
                      backgroundColor: AppColors.beige,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          AppColors.greenArtichoke),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Exo: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${widget.training.exercises[_exerciseIndex].name}")
                              ],
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              widget.training.exercises[_exerciseIndex].img !=
                                          null &&
                                      widget.training.exercises[_exerciseIndex]
                                          .img.isNotEmpty
                                  ? widget
                                      .training.exercises[_exerciseIndex].img
                                  : "images/jpec_logo.png",
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15, bottom: 8.0),
                            child: Text(
                              "${widget.training.exercises[_exerciseIndex].description}",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Center(
              child: _renderCurrentSetInfo(),
            )),
        InkWell(
          onTap: () {
            switchToTimerView();
          },
          child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              color: AppColors.greenArtichoke,
              child: Center(
                child: Text(
                  "DONE",
                  style: TextStyle(fontSize: 35),
                ),
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [_renderExerciseTab(), _renderTimerWidget()],
        ),
      ),
    );
  }
}
