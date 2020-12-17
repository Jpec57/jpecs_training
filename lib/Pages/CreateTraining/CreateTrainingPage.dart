import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Services/API/TrainingRequest.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';

const TAB_WORKOUT = 'WORKOUT';
const TAB_EXERCISE = 'EXERCISE';
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
  
  var items = ["a", "b", "c"];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _renderTestButton() {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          await createUserRequest();
        },
        child: Text("Clique"),
      ),
    );
  }

  Widget _renderExerciseView(){
    return Column(
      children: [
        RaisedButton(
          onPressed: (){

        },
        child: Text("Add"),),
        RaisedButton(onPressed: (){

        },
          child: Text("Cancel"),)
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
          children: items.map((item){
            return ExpansionPanel(

              headerBuilder: (BuildContext context, bool isExpanded) {
                return  ListTile(
                    title:  Text(
                      item,
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
            _tabController.index = 1;

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
