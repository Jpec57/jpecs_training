import 'package:flutter/material.dart';
import 'package:jpec_training/Models/Training.dart';

class TrainingShow extends StatefulWidget {
  static const routeName = '/training/show';
  final Training training;

  const TrainingShow({Key key, @required this.training}) : super(key: key);

  @override
  _TrainingShowState createState() => _TrainingShowState();
}

class _TrainingShowState extends State<TrainingShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("T bo"),
          Text(widget.training.name),

        ],
      ),
    );
  }
}
