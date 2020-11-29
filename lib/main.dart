import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Pages/CreateTraining/CreateTrainingPage.dart';
import 'package:jpec_training/Pages/InTrainingPage/InExercisePage.dart';
import 'package:jpec_training/Pages/InTrainingPage/InExercisePageArguments.dart';
import 'package:jpec_training/Pages/InTrainingPage/TrainingResultPage.dart';
import 'package:jpec_training/Pages/InTrainingPage/TrainingResultPageArguments.dart';
import 'package:jpec_training/Pages/TimerPage/TimerPage.dart';
import 'package:jpec_training/Pages/TrainingShowPage/TrainingShow.dart';
import 'package:jpec_training/Pages/TrainingShowPage/TrainingShowArgument.dart';

import 'Pages/HomePage/HomePage.dart';
import 'Widgets/Localization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      localizationsDelegates: [
        MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale(EN_LOCALE),
        const Locale(FR_LOCALE),
        const Locale(JAP_LOCALE),
      ],
      navigatorKey: Get.key,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
                  button: TextStyle(color: Colors.red),
                  headline1: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  headline2: TextStyle(fontSize: 30),
                  headline5: TextStyle(color: Colors.white),
                  headline6: TextStyle(color: Colors.white),
                  caption: TextStyle(fontSize: 20),
                  bodyText1: TextStyle(color: Colors.white, fontSize: 20),
                  bodyText2: TextStyle(color: Colors.white, fontSize: 20))
              .apply(fontFamily: 'Roboto'),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: AppColors.charlestonGreen,
          )),
      onGenerateRoute: (settings) {
        if (settings.name == TrainingShow.routeName) {
          final TrainingShowArgument args = settings.arguments;

          return MaterialPageRoute(
            builder: (context) {
              return TrainingShow(
                training: args.training,
              );
            },
          );
        }
        if (settings.name == InExercisePage.routeName) {
          final InExercisePageArguments args = settings.arguments;

          return MaterialPageRoute(
            builder: (context) {
              return InExercisePage(
                training: args.training,
              );
            },
          );
        }
        if (settings.name == TrainingResultPage.routeName) {
          final TrainingResultPageArguments args = settings.arguments;

          return MaterialPageRoute(
            builder: (context) {
              return TrainingResultPage(
                trainingData: args.trainingData,
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      routes: {
        // LoginPage.routeName: (context) => LoginPage(),
        TimerPage.routeName: (context) => TimerPage(),
        CreateTrainingPage.routeName: (context) => CreateTrainingPage(),
      },
      home: HomePage(),
      // home: TrainingResultPage(
      //     trainingData: TrainingData(trainingId: 1, doneExercises: [
      //   [
      //     new NamedExerciseSet(
      //         exerciseId: 1,
      //         name: "Dips",
      //         repsOrDuration: 10,
      //         rest: 60,
      //         weight: null),
      //     new NamedExerciseSet(
      //         exerciseId: 2,
      //         name: "Pull Ups",
      //         repsOrDuration: 5,
      //         rest: 60,
      //         weight: null),
      //     new NamedExerciseSet(
      //         exerciseId: 2,
      //         name: "Pull Ups",
      //         repsOrDuration: 7,
      //         rest: 60,
      //         weight: null),
      //   ],
      //   [
      //     new NamedExerciseSet(
      //         exerciseId: 3,
      //         name: "Push Ups",
      //         repsOrDuration: 3,
      //         rest: 60,
      //         weight: 40),
      //   ]
      // ])),

      // home: InExercisePage(),
      // home: InExerciseTimerPage(),
    );
  }
}

/*
TrainingResultPage(
        trainingData: TrainingData(trainingId: 1, doneExercises: [
          [
            new NamedExerciseSet(
                exerciseId: 1,
                name: "Dips",
                repsOrDuration: 10,
                rest: 60,
                weight: null),
            new NamedExerciseSet(
                exerciseId: 2,
                name: "Pull Ups",
                repsOrDuration: 5,
                rest: 60,
                weight: null),
            new NamedExerciseSet(
                exerciseId: 2,
                name: "Pull Ups",
                repsOrDuration: 7,
                rest: 60,
                weight: null),
          ],
          [
            new NamedExerciseSet(
                exerciseId: 3,
                name: "Push Ups",
                repsOrDuration: 3,
                rest: 60,
                weight: 40),
          ]
        ])
     )
 */
