import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpec_training/app_colors.dart';
import 'package:jpec_training/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:jpec_training/pages/home/home_page.dart';
import 'package:jpec_training/pages/timer/timer_page.dart';

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
                      image: AssetImage("assets/images/jpec_logo.png"),
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
            ListTile(
              title: Text("Log out"),
              onTap: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            )
          ],
        ),
      ),
    );
  }
}
