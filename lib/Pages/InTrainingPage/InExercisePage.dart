import 'package:flutter/material.dart';
import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Models/ExerciseSet.dart';
import 'package:jpec_training/Models/NamedExerciseSet.dart';
import 'package:jpec_training/Models/Training.dart';
import 'package:jpec_training/Models/TrainingData.dart';

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
  int _exerciseIndex = 0;
  int _setIndex = 0;
  // Timer tab
  bool _isHold = false;
  int _countdown = 49;
  int _doneReps = 18;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _trainingData = new TrainingData(trainingId: widget.training.id);
  }

  @override
  void dispose() {
    super.dispose();
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

  void progressInTraining() {}

  Widget _renderUpcomingExoNamePreview() {
    if (widget.training.exercises.length < _exerciseIndex) {
      return Text("End of workout.");
    }
    return Text("${widget.training.exercises[_exerciseIndex].name}");
  }

  Widget _renderUpcomingExoRowPreview() {
    List<Exercise> exercises = widget.training.exercises;
    if (exercises.length < _exerciseIndex) {
      return Center(child: Text("End of workout."));
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Image.asset(
            exercises[_exerciseIndex].img != null &&
                    exercises[_exerciseIndex].img.isNotEmpty
                ? exercises[_exerciseIndex].img
                : "images/jpec_logo.png",
          ),
        ),
        Flexible(
          child: Text(
            "${exercises[_exerciseIndex].description ?? ""}",
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
                      _tabController.index = 0;
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

  double getPercentTrainingProgression() {
    int totalSets = 0;
    int doneSets = 0;
    int nbCycle = widget.training.nbCycle ?? 1;

    for (Exercise exercise in widget.training.exercises) {
      totalSets += exercise.sets.length;
    }
    totalSets = nbCycle * totalSets;

    List<List<NamedExerciseSet>> doneExercisesPerCycle =
        _trainingData.doneExercises;
    for (List<NamedExerciseSet> cycleExercises in doneExercisesPerCycle) {
      doneSets += cycleExercises.length;
    }

    return doneSets / totalSets;
  }

  Widget _renderCurrentSetInfo() {
    String text;
    List<ExerciseSet> exoSets = widget.training.exercises[_exerciseIndex].sets;
    ExerciseSet currentSet = exoSets[_setIndex];
    if (currentSet.weight != null) {
      text = "${currentSet.repsOrDuration}r @ ${currentSet.weight}";
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
                      value: 0.4,
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
            _tabController.index = 1;
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
          controller: _tabController,
          children: [_renderExerciseTab(), _renderTimerWidget()],
        ),
      ),
    );
  }
}
