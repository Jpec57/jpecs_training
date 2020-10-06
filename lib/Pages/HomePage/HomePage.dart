import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Widgets/Clippers/BottomLeftCornerRoundedClipper.dart';
import 'package:jpec_training/Widgets/Localization.dart';
import 'package:jpec_training/Widgets/MainDrawer.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(LocalizationWidget.of(context).getLocalizeValue('home')),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30)),
              ),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Text("Push Ups", style: Theme.of(context).textTheme.bodyText2,),
                  Text("Push Ups"),
                  Text("data")
                ],
              ),
            ),
            Expanded(
                flex: 2, child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("49"),
                  RaisedButton(onPressed: (){}, child: Text("SKIP"),)
                ],
              ),
            )),
            Expanded(
                child: Container(
              color: AppColors.red,
              // color: Color(0xffff1616),
            ))
          ],
        ),
      ),
    );
  }
}
