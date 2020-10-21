import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Models/Training.dart';
import 'package:jpec_training/Services/Utils/utils.dart';
import 'package:jpec_training/Widgets/TopScrollablePage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<List<Training>> _chestTrainings;
  // Future<List<Training>> _backTrainings;
  // Future<List<Training>> _legsTrainings;
  Future<Map<String, dynamic>> _chestTrainings;
  Future<Map<String, dynamic>> _backTrainings;
  Future<Map<String, dynamic>> _legsTrainings;

  @override
  void initState() {
    super.initState();
    loadTrainingData();
  }

  loadTrainingData(){
    _chestTrainings = parseJsonFromAssets("lib/HardCodedData/chest_trainings.json");
    _backTrainings = parseJsonFromAssets("lib/HardCodedData/back_trainings.json");
    _legsTrainings = parseJsonFromAssets("lib/HardCodedData/legs_trainings.json");
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
                            color: AppColors.charlestonGreen
                          ),
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
                    itemCount: 20,
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
                                "Chest",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Container(
                              height: screenWidth * 0.3,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 20,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.charlestonGreen,
                                            width: 2),
                                        color: AppColors.greenArtichoke,
                                      ),
                                      height: screenWidth * 0.3,
                                      width: screenWidth * 0.4,
                                      child: Icon(Icons.photo),
                                    );
                                  }),
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
