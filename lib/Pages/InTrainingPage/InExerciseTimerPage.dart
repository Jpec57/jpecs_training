import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Models/Training.dart';

import 'InExercisePage.dart';
import 'InExercisePageArguments.dart';

class InExerciseTimerPage extends StatefulWidget {
  static const routeName = '/training/rest';
  final Training training;

  const InExerciseTimerPage({Key key, @required this.training})
      : super(key: key);

  @override
  _InExerciseTimerPageState createState() => _InExerciseTimerPageState();
}

class _InExerciseTimerPageState extends State<InExerciseTimerPage> {
  bool _isHold = false;
  int _countdown = 49;
  int _doneReps = 18;

  Widget _renderClickableRep(int num) {
    if (num < 0) {
      return Container();
    }
    return InkWell(
        onTap: () {
          setState(() {
            _doneReps = num;
          });
        },
        child: Text("$num"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.richBlack,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(30)),
                ),
                // height: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Next: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Exo 2")
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Image.asset(
                                  "images/jpec_logo.png",
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "BLABL ABALAB ezljfh kezjfez elfkh zekfnezl fezlnflkze nfozek lflz lken fozeno",
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "$_countdown",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              InExercisePage.routeName,
                              arguments: InExercisePageArguments(
                                  training: widget.training));
                        },
                        child: Text(
                          "SKIP",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              color: AppColors.greenArtichoke,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                    child: Text(
                      _isHold
                          ? "How long did you hold ?"
                          : "How many repetitions have you done ?",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _renderClickableRep(_doneReps - 2),
                          _renderClickableRep(_doneReps - 1),
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.charlestonGreen),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$_doneReps',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )),
                          _renderClickableRep(_doneReps + 1),
                          _renderClickableRep(_doneReps + 2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
