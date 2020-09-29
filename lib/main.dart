import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:jpec_training/Pages/HomePage/HomePage.dart';

import 'Widgets/Localization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        // primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 30)
        )
      ),
      onGenerateRoute: (settings) {
        // if (settings.name == DeckPage.routeName) {
        //   final DeckPageArguments args = settings.arguments;
        //
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       return DeckPage(
        //         id: args.id,
        //       );
        //     },
        //   );
        // }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      routes: {
        // LoginPage.routeName: (context) => LoginPage(),
      },
      home: HomePage(),
    );
  }
}


