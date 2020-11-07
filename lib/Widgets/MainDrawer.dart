import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Pages/HomePage/HomePage.dart';
import 'package:jpec_training/Pages/TimerPage/TimerPage.dart';
import 'package:jpec_training/Widgets/Localization.dart';

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
                      image: AssetImage("images/app_icon.png"),
                      fit: BoxFit.cover)),
            ),
            ListTile(
              title:
                  Text(LocalizationWidget.of(context).getLocalizeValue('home')),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  HomePage.routeName,
                );
              },
            ),
            ListTile(
              title: Text(
                  LocalizationWidget.of(context).getLocalizeValue('timer')),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TimerPage.routeName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
