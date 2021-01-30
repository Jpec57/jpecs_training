import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/authentication/bloc/authentication_bloc.dart';
import 'package:jpec_training/pages/HomePage/HomePage.dart';
import 'package:jpec_training/pages/TimerPage/TimerPage.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.richBlack,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '今日は',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/jpec_logo.png"),
                      fit: BoxFit.cover)),
            ),
            ListTile(
              title:
                  // Text(LocalizationWidget.of(context).getLocalizeValue('home')),
                  Text("Home"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  HomePage.routeName,
                );
              },
            ),
            ListTile(
              title: Text(
                  // LocalizationWidget.of(context).getLocalizeValue('timer')),
                  "Timer"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TimerPage.routeName,
                );
              },
            ),
            Builder(
              builder: (_) {
                return ListTile(
                  title: Text("Log out"),
                  onTap: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                    // Get.offUntil(LoginPage.route(), (route) => false);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
