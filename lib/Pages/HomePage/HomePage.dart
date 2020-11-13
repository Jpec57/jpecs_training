import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpec_training/Animations/SlideLeftPageAnimation.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/HardCodedData/trainings.dart';
import 'package:jpec_training/Models/Training.dart';
import 'package:jpec_training/Pages/TrainingShowPage/TrainingShow.dart';
import 'package:jpec_training/Widgets/TopScrollablePage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<dynamic>> _chestTrainings;
  Future<List<dynamic>> _backTrainings;
  Future<List<dynamic>> _legsTrainings;
  List<Map<String, dynamic>> _trainings = [];

  @override
  void initState() {
    super.initState();
    loadTrainingData();
  }

  loadTrainingData() {
    Map map = new Map<String, dynamic>();
    map.putIfAbsent("muscle", () => "Back");
    map.putIfAbsent("trainings", () => loadBackTrainings());
    _trainings.add(map);
    map = new Map<String, dynamic>();
    map.putIfAbsent("muscle", () => "Chest");
    map.putIfAbsent("trainings", () => loadChestTrainings());
    _trainings.add(map);
  }

  Widget _renderMuscleTrainings(List<Training> trainings, double screenWidth) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trainings.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              // splashColor: Colors.,
              onTap: () {
                Navigator.push(
                    context,
                    SlideLeftRoute(
                        page: TrainingShow(training: trainings[index])));

                // Get.toNamed(TrainingShow.routeName,
                //     arguments:
                //         TrainingShowArgument(training: trainings[index]));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: AppColors.charlestonGreen, width: 2),
                  color: AppColors.greenArtichoke,
                ),
                height: screenWidth * 0.3,
                width: screenWidth * 0.4,
                child: Center(
                  child: Text(
                    trainings[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.richBlack,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.grey,
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return TopScrollablePage(
        headerChild: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/fluff.png"), fit: BoxFit.cover),
          ),
          // the more we advance, the smaller it should get (1 - ratio)
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        "Next: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("data")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomChild: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trainings",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        splashColor: Colors.black12,
                        onTap: () {
                          print("Creating a training");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.charlestonGreen),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _trainings.length,
                    itemBuilder: (BuildContext context, int categoryIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                _trainings[categoryIndex]['muscle'],
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Container(
                              height: screenWidth * 0.3,
                              child: FutureBuilder(
                                future: _trainings[categoryIndex]['trainings'],
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Training>>
                                        trainingSnap) {
                                  switch (trainingSnap.connectionState) {
                                    case ConnectionState.done:
                                      // List<Training> trainings = trainingSnap
                                      //     .data
                                      //     .map(
                                      //         (json) => Training.fromJson(json))
                                      //     .toList();
                                      return _renderMuscleTrainings(
                                          trainingSnap.data, screenWidth);
                                    default:
                                      return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
