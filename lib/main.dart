import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/authentication/bloc/authentication_bloc.dart';
import 'package:jpec_training/login/view/login_page.dart';
import 'package:jpec_training/pages/CreateTraining/CreateTrainingPage.dart';
import 'package:jpec_training/pages/HomePage/HomePage.dart';
import 'package:jpec_training/pages/InTrainingPage/InExercisePage.dart';
import 'package:jpec_training/pages/InTrainingPage/InExercisePageArguments.dart';
import 'package:jpec_training/pages/InTrainingPage/TrainingResultPage.dart';
import 'package:jpec_training/pages/InTrainingPage/TrainingResultPageArguments.dart';
import 'package:jpec_training/pages/TimerPage/TimerPage.dart';
import 'package:jpec_training/pages/TrainingShowPage/TrainingShow.dart';
import 'package:jpec_training/pages/TrainingShowPage/TrainingShowArgument.dart';
import 'package:jpec_training/splash/view/splash_page.dart';
import 'package:user_repository/user_repository.dart';

import 'Widgets/Localization.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

//https://bloclibrary.dev/#/flutterlogintutorial
class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    Key key,
  }) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
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
          cardColor: AppColors.greenArtichoke,
          cardTheme: CardTheme(
            color: Colors.black,
          ),
          textTheme: TextTheme(
              button: TextStyle(color: Colors.red),
              headline1: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PermanentMarker'),
              headline2: TextStyle(fontSize: 30, fontFamily: 'PermanentMarker'),
              headline3: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'PermanentMarker'),
              headline4: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'PermanentMarker'),
              headline5:
                  TextStyle(color: Colors.white, fontFamily: 'PermanentMarker'),
              headline6: TextStyle(color: Colors.white, fontFamily: 'NerkoOne'),
              caption: TextStyle(fontSize: 20),
              bodyText1: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Roboto'),
              bodyText2: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Roboto')),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: AppColors.charlestonGreen,
          )),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                //TODO
                print("authenticated");
                Get.offNamedUntil(HomePage.routeName, (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                print("unauthenticated");
                Get.offUntil(LoginPage.route(), (route) => false);

                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
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
        return SplashPage.route();
      },
      routes: {
        // LoginPage.routeName: (context) => LoginPage(),
        TimerPage.routeName: (context) => TimerPage(),
        CreateTrainingPage.routeName: (context) => CreateTrainingPage(),
      },
      home: HomePage(),
      //home: CreateTrainingPage(),
      //    home: InExercisePage(),
//      home: InExerciseTimerPage(),
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
