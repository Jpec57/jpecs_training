import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Enums/MuscleEnum.dart';
import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Services/API/TrainingRequest.dart';
import 'package:jpec_training/Widgets/DefaultButton.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';
import 'package:jpec_training/Services/Utils/stringExtension.dart';

const TAB_WORKOUT = 'WORKOUT';
const TAB_WORKOUT_INDEX = 0;
const TAB_EXERCISE = 'EXERCISE';
const TAB_EXERCISE_INDEX = 1;
class CreateTrainingPage extends StatefulWidget {
  static const routeName = "/training/create";

  @override
  _CreateTrainingPageState createState() => _CreateTrainingPageState();
}

class _CreateTrainingPageState extends State<CreateTrainingPage> with SingleTickerProviderStateMixin{
  final List<Tab> myTabs = <Tab>[
    Tab(text: TAB_WORKOUT),
    Tab(text: TAB_EXERCISE),
  ];
  TabController _tabController;
  List<Exercise> _exercises;
  
  var items = ["a", "b", "c"];

  @override
  void initState() {
    super.initState();
    _exercises = [];
    _tabController = new TabController(length: myTabs.length, vsync: this);
    _tabController.index = TAB_EXERCISE_INDEX;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _renderExerciseView(){
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 50),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,

            children: ((MuscleEnum.getAll()).map((muscle){
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: RaisedButton(
                  color: AppColors.greenArtichoke,
                    onPressed: (){},
                child: Text("${muscle.toUpperCase()}",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              );
            })).toList(),
          ),
        ),
        DefaultButton(onPressed: (){
          _tabController.index = TAB_WORKOUT_INDEX;
        },
          text: "Add",
        ),
        DefaultButton(onPressed: (){
          _tabController.index = TAB_WORKOUT_INDEX;
        },
          text: "Cancel",
        )
      ],
    );
  }


  Widget _renderTrainingView(){
    return Column(
      children: [
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              // items[index].isExpanded = !items[index].isExpanded;
            });
          },
          children: _exercises.map((exercise){
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return  ListTile(
                    title:  Text(
                      exercise.name,
                      textAlign: TextAlign.left,
                      style:  TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                );
              },
              isExpanded: true,
              body: Text("Contenu"),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: IconButton(icon: Icon(Icons.add_circle, color: AppColors.beige, size: 40,), onPressed: (){
            _tabController.index = TAB_EXERCISE_INDEX;
          }),
        ),
        Container(
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: Container(
        color: AppColors.charlestonGreen,
        child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: myTabs.map((Tab tab) {
            final String label = tab.text;
            switch (label){
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
