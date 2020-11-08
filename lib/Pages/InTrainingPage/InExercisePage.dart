import 'package:flutter/material.dart';
import 'package:jpec_training/Models/Training.dart';
import 'package:jpec_training/Pages/InTrainingPage/InExerciseTimerPage.dart';
import 'package:jpec_training/Pages/InTrainingPage/InExerciseTimerPageArguments.dart';

import '../../AppColors.dart';

class InExercisePage extends StatefulWidget {
  static const routeName = "/training/exercise";
  final Training training;

  const InExercisePage({Key key, @required this.training}) : super(key: key);

  @override
  _InExercisePageState createState() => _InExercisePageState();
}

class _InExercisePageState extends State<InExercisePage> {
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
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.richBlack,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(30)),
                ),
                // height: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 20, left: 8, right: 8),
                        child: LinearProgressIndicator(
                          value: 0.4,
                          backgroundColor: AppColors.beige,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              AppColors.greenArtichoke),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8.0),
                      //   child: TrainingProgressBar(),
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Exo: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Pull ups")
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Image.asset(
                                  "images/jpec_logo.png",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 8.0),
                                child: Text(
                                  "Blablabla",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
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
                          "10 @ 45",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        ),
                      ),
                    ],
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(InExerciseTimerPage.routeName,
                    arguments: InExerciseTimerPageArguments(
                        training: widget.training));
              },
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  color: AppColors.greenArtichoke,
                  child: Center(
                    child: Text(
                      "DONE",
                      style: TextStyle(fontSize: 35),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
