import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Enums/MuscleEnum.dart';
import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Models/ExerciseSet.dart';
import 'package:jpec_training/Pages/HomePage/HomePage.dart';
import 'package:jpec_training/Widgets/DefaultButton.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';
import 'package:jpec_training/Widgets/Dialogs/ExerciseExplanationDialog.dart';

const TAB_WORKOUT = 'WORKOUT';
const TAB_WORKOUT_INDEX = 0;
const TAB_EXERCISE = 'EXERCISE';
const TAB_EXERCISE_INDEX = 1;
const DEFAULT_SEARCH_SIZE = 40;
const BIG_SEARCH_SIZE = 250;

class CreateTrainingPage extends StatefulWidget {
  static const routeName = "/training/create";

  @override
  _CreateTrainingPageState createState() => _CreateTrainingPageState();
}

class _CreateTrainingPageState extends State<CreateTrainingPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: TAB_WORKOUT),
    Tab(text: TAB_EXERCISE),
  ];
  TextEditingController _searchExerciseController;
  TabController _tabController;
  List<Exercise> _exercises;
  //ExerciseView
  List<String> _selectedMuscles = [];
  double _searchBarWidth;

  @override
  void initState() {
    super.initState();
    _exercises = [];
    _tabController = new TabController(length: myTabs.length, vsync: this);
    _tabController.index = TAB_EXERCISE_INDEX;
    _searchBarWidth = DEFAULT_SEARCH_SIZE * 1.0;
    _searchExerciseController = new TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchExerciseController.dispose();
    super.dispose();
  }

  _renderMusclesToSelect(List<String> muscles) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 40),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: ((muscles).map((muscle) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: RaisedButton(
                color: _selectedMuscles.contains(muscle)
                    ? AppColors.greenArtichoke
                    : Colors.grey,
                onPressed: () {
                  if (_selectedMuscles.contains(muscle)) {
                    _selectedMuscles.remove(muscle);
                  } else {
                    _selectedMuscles.add(muscle);
                  }
                  setState(() {});
                },
                child: Text(
                  "${muscle.toUpperCase()}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          );
        })).toList(),
      ),
    );
  }

  _triggerExerciseSearch(){
    print("_triggerExerciseSearch");
    if (_searchBarWidth > DEFAULT_SEARCH_SIZE){
      print("TO DEFAULT");
      _searchBarWidth = DEFAULT_SEARCH_SIZE * 1.0;
    } else {
      print("SEARCHING");
      _searchBarWidth = BIG_SEARCH_SIZE * 1.0;
    }
    setState(() {

    });
  }

  Widget _renderExerciseView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8.0),
          child: AnimatedContainer(
            width: _searchBarWidth,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.greenArtichokeDarker,
              borderRadius: BorderRadius.circular(10)
            ),
            duration: Duration(milliseconds: 800),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: _searchBarWidth > DEFAULT_SEARCH_SIZE + 50,
                        child: Expanded(child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: (){
                                  _searchExerciseController.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Icon(Icons.close, color: Colors.grey, size: 20,),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                                child: TextField(controller: _searchExerciseController)),
                          ],
                        ))),
                    GestureDetector(
                      onTap: (){
                        _triggerExerciseSearch();
                      },
                        child: Icon(Icons.search, color: AppColors.beige,)),
                  ],
                ),
              ),
            ),
          ),
        ),
        _renderMusclesToSelect(MuscleEnum.getUpperBody()),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: _renderMusclesToSelect(MuscleEnum.getLowerBody()),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      print(_exercises);
                      _exercises.add(new Exercise(name: 'Toto', sets: [new ExerciseSet(repsOrDuration: 30, rest: 50)]));
                      _tabController.index = TAB_WORKOUT_INDEX;
                      print(_exercises);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.greenArtichokeDarker),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(ExerciseExplanationDialog());
                                },
                                child: Image.asset(
                                  'images/jpec_logo.png',
                                  height: 90,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Exercise name",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Triceps",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.fitness_center,
                                              size: 16,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(
                                                "Pull up bar",
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: 5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: DefaultButton(
                  buttonColor: Colors.grey,
                  textColor: Colors.white,
                  onPressed: () {
                    _tabController.index = TAB_WORKOUT_INDEX;
                  },
                  text: "Cancel",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: DefaultButton(
                  buttonColor: AppColors.greenArtichoke,
                  onPressed: () {
                    _tabController.index = TAB_WORKOUT_INDEX;
                  },
                  text: "Add",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _renderTrainingView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.beige,
            onPressed: () {
              Get.toNamed(HomePage.routeName);
            },
          ),
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                // items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: _exercises.map((exercise) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                      title: Text(
                    exercise.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ));
                },
                isExpanded: true,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Test"),
                    ...exercise.sets.map((exercise){
                      return Column(
                        children: [
                          Row(
                            children: [
                            Text('Rest ${exercise.rest}'),
                              Text('Reps ${exercise.repsOrDuration}'),
                          ],)
                        ],
                      );
                    }).toList(),
                    IconButton(icon: Icon(Icons.add_circle), onPressed: (){
                      exercise.sets.add(new ExerciseSet(repsOrDuration: 10, rest: 60));
                      setState(() {

                      });
                    })
                  ],
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: AppColors.beige,
                  size: 40,
                ),
                onPressed: () {
                  _tabController.index = TAB_EXERCISE_INDEX;
                }),
          ),
          Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      withAppBar: false,
      child: Container(
        color: AppColors.charlestonGreen,
        child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: myTabs.map((Tab tab) {
            final String label = tab.text;
            switch (label) {
              case TAB_WORKOUT:
                return _renderTrainingView();
              case TAB_EXERCISE:
                return _renderExerciseView();
            }
            return Container();
          }).toList(),
        ),
      ),
    );
  }
}
