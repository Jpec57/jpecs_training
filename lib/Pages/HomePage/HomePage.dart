import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Widgets/Clippers/TopCornerRoundedClipper.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text("Next: ", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("data")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.richBlack,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Hello"),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
