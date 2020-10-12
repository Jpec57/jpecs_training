import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.richBlack,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30)),
              ),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Next available", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("data")
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2, child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("49"),
                  RaisedButton(
                    onPressed: (){
                    }, child: Text("SKIP", style: Theme.of(context).textTheme.bodyText2,),)
                ],
              ),
            )),
            Expanded(
                child: Container(
                  color: AppColors.greenArtichoke,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('18'),
                      Text('19'),
                      Text('20'),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
