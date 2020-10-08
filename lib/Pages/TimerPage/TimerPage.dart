import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _currentSet = 6;
  int _countdown = 0;

  Widget _renderTimerButton(int time) {
    return Expanded(
      child: InkWell(
        onTap: (){
          setState(() {
            _countdown = time;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              "$time",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderTimerRow(int time1, int time2) {
    return Expanded(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _renderTimerButton(time1),
          _renderTimerButton(time2),
        ],
      ),
    );
  }

  Widget _renderSet(int setNumber) {
    Color backgroundColor = AppColors.richBlack;
    Color textColor = Colors.white;
    if (_currentSet == setNumber) {
      backgroundColor = AppColors.greenArtichoke;
      textColor = Colors.white;
    }
    return Expanded(
        child: InkWell(
          onTap: (){
            setState(() {
              _currentSet = setNumber;
            });
          },
          child: Container(
      decoration: BoxDecoration(
          color: AppColors.richBlack,
      ),
      child: Center(
            child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                    border:
                        Border.all(color: AppColors.charlestonGreen, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    '$setNumber',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                ))),
    ),
        ));
  }

  Widget _renderSetRow() {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _renderSet(1),
          _renderSet(2),
          _renderSet(3),
          _renderSet(4),
          _renderSet(5),
          _renderSet(6),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _renderSetRow(),
        _renderTimerRow(25, 60),
        _renderTimerRow(90, 120),
        _renderTimerRow(240, 360),
      ],
    ));
  }
}
