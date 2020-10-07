import 'package:flutter/material.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Widget _renderTimerButton(int time) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          "$time",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderTimerButton(25),
              _renderTimerButton(60),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderTimerButton(25),
              _renderTimerButton(60),
            ],
          ),
        ),
      ],
    ));
  }
}
