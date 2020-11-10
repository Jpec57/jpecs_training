import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Models/Exercise.dart';
import 'package:jpec_training/Models/ExerciseSet.dart';
import 'package:jpec_training/Models/Training.dart';
import 'package:jpec_training/Pages/InTrainingPage/InExercisePage.dart';
import 'package:jpec_training/Pages/InTrainingPage/InExercisePageArguments.dart';
import 'package:jpec_training/Widgets/TopScrollablePage.dart';

class TrainingShow extends StatefulWidget {
  static const routeName = '/training/show';
  final Training training;

  const TrainingShow({Key key, @required this.training}) : super(key: key);

  @override
  _TrainingShowState createState() => _TrainingShowState();
}

class _TrainingShowState extends State<TrainingShow> {
  String getSetsText(Exercise exercise) {
    List<ExerciseSet> sets = exercise.sets;
    List<int> reps = [];
    int defaultNb = sets[0].repsOrDuration;
    bool hasDifferentReps = false;
    for (ExerciseSet exerciseSet in sets) {
      int nb = exerciseSet.repsOrDuration;
      reps.add(nb);
      if (defaultNb != nb) {
        hasDifferentReps = true;
      }
    }
    if (hasDifferentReps) {
      return "${sets.length}*(${reps.join('-')})";
    }
    return "${sets.length}*${reps[0]}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TopScrollablePage(
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
                          "Last time: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "07/12/2020",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomChild: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(widget.training.name),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: RaisedButton(
                  child: Text(
                    "Start".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, InExercisePage.routeName,
                        arguments:
                            InExercisePageArguments(training: widget.training));
                  },
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.training.exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  Exercise exo = widget.training.exercises[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.greenArtichoke,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        onTap: () {
                          //TODO Expand another tile with more info
                        },
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Image.asset(
                                "images/jpec_logo.png",
                                height: 50,
                              ),
                            )
                          ],
                        ),
                        title: Text("${exo.name}"),
                        subtitle: Text(
                          '${exo.requiredMaterial.join(', ')}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Text(
                          getSetsText(exo),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Text("Number of cycle: ${widget.training.nbCycle ?? 1}"),
              Text(
                  "Rest between cycle: ${widget.training.restBetweenCycle ?? 60}sec"),
            ],
          ),
        ),
      ),
    );
  }
}
