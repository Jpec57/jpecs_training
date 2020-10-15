import 'package:flutter/material.dart';

class InExercisePage extends StatefulWidget {
  static const routeName = '/training/in';
  @override
  _InExercisePageState createState() => _InExercisePageState();
}

class _InExercisePageState extends State<InExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("efezf"),
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("a", style: TextStyle(color: Colors.black),),
            Container(
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("b", style: TextStyle(color: Colors.black),),
                  Text("c", style: TextStyle(color: Colors.black),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
