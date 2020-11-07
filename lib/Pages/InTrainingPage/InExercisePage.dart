import 'package:flutter/material.dart';

import '../../AppColors.dart';

class InExercisePage extends StatefulWidget {
  static const routeName = "/training/exercise";

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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Exo: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("data")
                        ],
                      ),
                      Image.asset(
                        "images/app_icon.png",
                        height: 50,
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
            Container(
                height: MediaQuery.of(context).size.height * 0.15,
                color: AppColors.greenArtichoke,
                child: Center(
                  child: Text(
                    "DONE",
                    style: TextStyle(fontSize: 35),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
