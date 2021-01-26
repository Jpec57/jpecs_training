import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Models/ExerciseSet.dart';
import 'package:jpec_training/Models/NamedExerciseSet.dart';
import 'package:jpec_training/Models/Training.dart';
import 'package:jpec_training/Models/TrainingData.dart';
import 'package:jpec_training/Pages/InTrainingPage/TrainingResultPage.dart';
import 'package:jpec_training/Pages/InTrainingPage/TrainingResultPageArguments.dart';
import 'package:jpec_training/Services/InWorkoutService.dart';
import 'package:jpec_training/Widgets/Dialogs/ConfirmDialog.dart';
import 'package:jpec_training/Widgets/TrainingProgressBar.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AppColors.dart';

class InExercisePage extends StatefulWidget {
  static const routeName = "/training/exercise";
  final Training training;

  const InExercisePage({Key key, @required this.training}) : super(key: key);

  @override
  _InExercisePageState createState() => _InExercisePageState();
}

const CACHED_SOUNDS = ['sounds/beep_start.mp3', 'sounds/beep_end.mp3'];

class _InExercisePageState extends State<InExercisePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TrainingData _trainingData;
  static const EXERCISE_TAB_INDEX = 0;
  static const TIMER_TAB_INDEX = 1;
  static const TIMER_START_INDEX = 2;
  static const TIME_BEFORE_TRAINING = 5;

  //Exercise tab
  int _cycleIndex = 0;
  int _exerciseIndex = 0;
  int _setIndex = 0;
  // Timer tab
  bool _isHold = false;
  int _countdown = 60;
  int _doneReps = 0;
  int _totalTime = 0;
  int _countdownBeforeStart = TIME_BEFORE_TRAINING;
  Timer _timer;
  Timer _trainingTimer;
  Timer _beforeTrainingTimer;
  //Audio
  AudioCache _audioPlayer = AudioCache();

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
    _tabController = new TabController(length: 3, vsync: this);
    _trainingData = new TrainingData(trainingId: widget.training.id);
    _trainingData.doneExercises = initDoneExercises();
    _audioPlayer.loadAll(CACHED_SOUNDS);
    Screen.keepOn(true);
    _tabController.index = TIMER_START_INDEX;
    _beforeTrainingTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdownBeforeStart = _countdownBeforeStart - 1;
      });
      if (_countdownBeforeStart < 3) {
        _audioPlayer.play(CACHED_SOUNDS[(_countdownBeforeStart == 0) ? 1 : 0]);
      }

      if (_countdownBeforeStart <= 0) {
        startTrainingTimers();
        _tabController.index = EXERCISE_TAB_INDEX;
        _beforeTrainingTimer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _trainingData = null;
    clean();
  }

  void startTrainingTimers() {
    _trainingTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _totalTime = _totalTime + 1;
      });
    });
    if (widget.training.exercises[_exerciseIndex].isHold) {
      _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _doneReps = _doneReps + 1;
        });
      });
    }
  }

  void clean() {
    if (_beforeTrainingTimer != null && _beforeTrainingTimer.isActive) {
      _beforeTrainingTimer.cancel();
    }
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    if (_trainingTimer != null && _trainingTimer.isActive) {
      _trainingTimer.cancel();
    }
    _tabController.dispose();
    for (String sound in CACHED_SOUNDS) {
      _audioPlayer.clear(sound);
    }
  }

  Exercise _getCurrentExo() {
    return widget.training.exercises[_exerciseIndex];
  }

  void startCountDown(int time) {
    setState(() {
      _countdown = time;
    });
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown = _countdown - 1;
      });
      if (_countdown == 10) {
        _audioPlayer.play(CACHED_SOUNDS[0]);
      }

      if (_countdown < 3) {
        _audioPlayer.play(CACHED_SOUNDS[(_countdown == 0) ? 1 : 0]);
      }
      if (_countdown <= 0) {
        _timer.cancel();
        switchToExerciseView();
      }
    });
  }

  Future<void> saveTrainingData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    DateTime now = new DateTime.now();
    //now.toIso8601String()
    sharedPreferences.setString('last', _trainingData.toString());
  }

  void _addTrainingData(Exercise currentExo) {
    print("ADDING TRAINING DATA: ${currentExo.name}");
    ExerciseSet currentSet = currentExo.sets[_setIndex];
    //TODO take real rest
    _trainingData.doneExercises[_cycleIndex].add(new NamedExerciseSet(
        name: currentExo.name,
        repsOrDuration: _doneReps,
        weight: currentSet.weight,
        // rest: currentSet.rest - _countdown,
        rest: currentSet.rest,
        exerciseId: currentExo.id));
    print('TRAINING DATA ${_trainingData}');
  }

  void switchToExerciseView() async {
    //Remove any timer from timer page that could be ongoing
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    List<Exercise> exercises = widget.training.exercises;
    Exercise currentExo = _getCurrentExo();
    _addTrainingData(currentExo);
    _doneReps = 0;

    _tabController.index = EXERCISE_TAB_INDEX;
    int nbSets = currentExo.sets.length;
    if (_setIndex + 1 == nbSets) {
      _setIndex = 0;
      //Changing exercise ?
      if (_exerciseIndex + 1 == exercises.length) {
        _exerciseIndex = 0;
        //Changing cycle ?
        int nbCycle = widget.training.nbCycle ?? 1;
        if (_cycleIndex + 1 == nbCycle) {
          //TODO Save data
          await saveTrainingData();
          Navigator.of(context).pushNamed(TrainingResultPage.routeName,
              arguments:
                  TrainingResultPageArguments(trainingData: _trainingData));
          // Navigator.of(context).pushNamed(HomePage.routeName);
        } else {
          _cycleIndex++;
        }
      } else {
        _exerciseIndex++;
      }
    } else {
      _setIndex++;
    }
    currentExo = _getCurrentExo();
    if (currentExo.isHold) {
      _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _doneReps = _doneReps + 1;
        });
        int goal = currentExo.sets[_setIndex].repsOrDuration;
        if (goal - _doneReps < 3 && goal - _doneReps >= 0) {
          if (_doneReps == goal) {
            _audioPlayer.play(CACHED_SOUNDS[1]);
          } else {
            _audioPlayer.play(CACHED_SOUNDS[0]);
          }
        }
      });
    }
    //TODO 面目ない
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  void showLeaveTrainingDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => ConfirmDialog(
              action: "Do you want to leave this workout ?",
              positiveCallback: () async {
                await saveTrainingData();
                clean();
                Navigator.of(context).pushNamed(TrainingResultPage.routeName,
                    arguments: TrainingResultPageArguments(
                        trainingData: _trainingData));
                // Navigator.of(context).pushNamed(HomePage.routeName);
              },
            ));
  }

  void switchToTimerView() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    Exercise currentExo = _getCurrentExo();
    if (isWorkoutOver(widget.training, _trainingData, beforeInsert: true)) {
      _countdown = 0;
    } else {
      if (_setIndex + 1 < currentExo.sets.length) {
        startCountDown(currentExo.sets[_setIndex].rest);
      } else {
        int finalRest = currentExo.restAfter ?? currentExo.sets[_setIndex].rest;
        startCountDown(finalRest + 1);
      }
    }
    _tabController.index = TIMER_TAB_INDEX;
    if (!currentExo.isHold) {
      _doneReps = currentExo.sets[_setIndex].repsOrDuration;
    }
    setState(() {});
    //TODO I am deeply ashamed of myself
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  Widget _renderUpcomingExoNamePreview() {
    Exercise nextExo = getNextExercise(
        widget.training, _cycleIndex, _exerciseIndex, _setIndex);
    if (nextExo == null) {
      return Text("End of workout.");
    }
    int nbSets = _getCurrentExo().sets.length;
    int followingSet = _setIndex + 1;
    if (nbSets == _setIndex + 1) {
      followingSet = 0;
      nbSets = nextExo.sets.length;
    }
    return Flexible(
        child: Text(
      "${nextExo.name} (${followingSet + 1}/${nextExo.sets.length})",
      textAlign: TextAlign.center,
    ));
  }

  Widget _renderUpcomingExoRowPreview() {
    Exercise nextExo = getNextExercise(
        widget.training, _cycleIndex, _exerciseIndex, _setIndex);
    if (nextExo == null) {
      return Center(
          child: Icon(
        Icons.outlined_flag,
        color: Colors.white,
      ));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Image.asset(
            nextExo.img != null && nextExo.img.isNotEmpty
                ? nextExo.img
                : "images/jpec_logo.png",
            height: 100,
          ),
        ),
        Flexible(
          child: Text(
            "${nextExo.description ?? "No description"}",
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }

  /// TIMER VIEW

  Widget _renderClickableRep(int num) {
    if (num < 0) {
      return Expanded(child: Container());
    }
    return Expanded(
      child: InkWell(
          onTap: () {
            setState(() {
              _doneReps = num;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AutoSizeText(
              "$num",
              textAlign: TextAlign.center,
              minFontSize: 25,
              maxFontSize: 35,
            ),
          )),
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
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, left: 8, right: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              showLeaveTrainingDialog();
                            },
                            child: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            )),
                        Expanded(
                          child: TrainingProgressBar(
                              elapsedTime: _totalTime,
                              value: getPercentTrainingProgression(
                                  widget.training, _trainingData,
                                  beforeInsert: true)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _renderUpcomingExoNamePreview()
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 8.0, left: 15.0, right: 15),
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
                  style: Theme.of(context).textTheme.headline5
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _renderClickableRep(_doneReps - 2),
                      _renderClickableRep(_doneReps - 1),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.charlestonGreen),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              '$_doneReps',
                              minFontSize: 30,
                              maxFontSize: 40,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  // fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
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
    Exercise currentExo = _getCurrentExo();
    List<ExerciseSet> exoSets = currentExo.sets;
    ExerciseSet currentSet = exoSets[_setIndex];
    if (currentExo.isHold) {
      text = "${_doneReps}s";
    } else {
      if (currentSet.weight != null) {
        text = "${currentSet.repsOrDuration}r @ ${currentSet.weight}kg";
      } else {
        text = "${currentSet.repsOrDuration}r";
      }
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              showLeaveTrainingDialog();
                            },
                            child: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            )),
                        Expanded(
                          child: TrainingProgressBar(
                              elapsedTime: _totalTime,
                              value: getPercentTrainingProgression(
                                  widget.training, _trainingData)),
                        ),
                      ],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Exo: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                  child: Text(
                                    "${widget.training.exercises[_exerciseIndex].name}",
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                widget.training.exercises[_exerciseIndex].img !=
                                            null &&
                                        widget
                                            .training
                                            .exercises[_exerciseIndex]
                                            .img
                                            .isNotEmpty
                                    ? widget
                                        .training.exercises[_exerciseIndex].img
                                    : "images/jpec_logo.png",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                            child: Text(
                              "${widget.training.exercises[_exerciseIndex].description ?? ""}",
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

  _renderStartCountDown() {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(
          "$_countdownBeforeStart",
          style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  List<Widget> _tabsRender() {
    return [
      _renderExerciseTab(),
      _renderTimerWidget(),
      _renderStartCountDown()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _tabsRender(),
        ),
      ),
    );
  }
}
