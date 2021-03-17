import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Splash",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.black),
            ),
            CircularProgressIndicator(),
          ],
        )),
      ),
    );
  }
}
