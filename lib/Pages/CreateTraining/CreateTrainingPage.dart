import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Services/API/TrainingRequest.dart';

class CreateTrainingPage extends StatefulWidget {
  static const routeName = "/training/create";
  @override
  _CreateTrainingPageState createState() => _CreateTrainingPageState();
}

class _CreateTrainingPageState extends State<CreateTrainingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: AppColors.charlestonGreen,
      child: Center(child: RaisedButton(onPressed: () async{
        await createUserRequest();
      },
        child: Text("Clique"),
      ),),),
    );
  }
}
