import 'package:flutter/material.dart';
import 'package:jpec_training/Models/TrainingData.dart';

class TrainingResultPage extends StatefulWidget {
  static const routeName = "/training/result";
  final TrainingData trainingData;

  const TrainingResultPage({Key key, @required this.trainingData})
      : super(key: key);

  @override
  _TrainingResultPageState createState() => _TrainingResultPageState();
}

class _TrainingResultPageState extends State<TrainingResultPage> {
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
    return Container();
  }
}
