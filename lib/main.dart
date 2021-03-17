import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:jpec_training/app_colors.dart';
import 'package:jpec_training/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:jpec_training/blocs/login/view/login_page.dart';
import 'package:jpec_training/pages/create_training/create_training_page.dart';
import 'package:jpec_training/pages/home/home_page.dart';
import 'package:jpec_training/pages/in_training/in_exercise_page.dart';
import 'package:jpec_training/pages/in_training/in_exercise_page_arguments.dart';
import 'package:jpec_training/pages/in_training/training_result_page.dart';
import 'package:jpec_training/pages/in_training/training_result_page_arguments.dart';
import 'package:jpec_training/pages/timer/timer_page.dart';
import 'package:jpec_training/pages/training_show/training_show_page.dart';
import 'package:jpec_training/pages/training_show/training_show_page_argument.dart';
import 'package:jpec_training/blocs/splash/view/splash_page.dart';
import 'package:user_repository/user_repository.dart';

import 'Widgets/localization.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

//https://bloclibrary.dev/#/flutterlogintutorial
class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (_) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                  userRepository: userRepository)),
          // BlocProvider<ServerBloc>(create: (_) => ServerBloc())
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    Key? key,
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
          primaryColor: AppColors.charlestonGreen,
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
          final TrainingShowArgument? args = settings.arguments as TrainingShowArgument?;

          return MaterialPageRoute(
            builder: (context) {
              return TrainingShow(
                training: args!.training,
              );
            },
          );
        }
        if (settings.name == InExercisePage.routeName) {
          final InExercisePageArguments? args = settings.arguments as InExercisePageArguments?;

          return MaterialPageRoute(
            builder: (context) {
              return InExercisePage(
                training: args!.training,
              );
            },
          );
        }
        if (settings.name == TrainingResultPage.routeName) {
          final TrainingResultPageArguments? args = settings.arguments as TrainingResultPageArguments?;

          return MaterialPageRoute(
            builder: (context) {
              return TrainingResultPage(
                trainingData: args!.trainingData,
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
