import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';

class InTimerPage extends StatefulWidget {
  @override
  _InTimerPageState createState() => _InTimerPageState();
}

class _InTimerPageState extends State<InTimerPage> {
  bool _isHold = false;

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
                  child: Column(
                    children: [
                      Text(_isHold ? "How long did you ?" : "How many repetitions ?"),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('18'),
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.charlestonGreen
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('19', style: TextStyle(fontWeight: FontWeight.bold),),
                              )
                          ),
                          Text('20'),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
