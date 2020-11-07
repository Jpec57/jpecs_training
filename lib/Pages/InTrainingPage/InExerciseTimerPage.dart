import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';

class InExerciseTimerPage extends StatefulWidget {
  static const routeName = '/training/rest';
  @override
  _InExerciseTimerPageState createState() => _InExerciseTimerPageState();
}

class _InExerciseTimerPageState extends State<InExerciseTimerPage> {
  bool _isHold = false;

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
                          Text("data")
                        ],
                      ),
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
                          "49",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
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
                          Text('17'),
                          Text('18'),
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.charlestonGreen),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '19',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )),
                          Text('20'),
                          Text('21'),
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
