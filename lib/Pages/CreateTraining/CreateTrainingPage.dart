import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Services/API/TrainingRequest.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';

class CreateTrainingPage extends StatefulWidget {
  static const routeName = "/training/create";

  @override
  _CreateTrainingPageState createState() => _CreateTrainingPageState();
}

class _CreateTrainingPageState extends State<CreateTrainingPage> {
  var items = ["a", "b", "c"];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: Container(
        color: AppColors.charlestonGreen,
        child: Column(
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

            ExpansionTile(title: Container(child: Text("Test extension")),
            children: [
              Text('Exercise 1'),
              Text('Exercise 2'),
            ],),
            RaisedButton(onPressed: (){

            }, child: Text("Add".toUpperCase()),
            ),
            IconButton(icon: Icon(Icons.add_circle, color: AppColors.beige,), onPressed: (){

            }),
            Container(
            ),
          ],
        ),
      ),
    );
  }
}
