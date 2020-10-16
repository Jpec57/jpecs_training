import 'package:flutter/material.dart';
import 'package:jpec_training/AppColors.dart';
import 'package:jpec_training/Widgets/DefaultScaffold.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _topRadius = 70;
  double _offset = 0;
  double _headerPercentHeight = 0.35;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(onScroll);
  }

  onScroll() {
    setState(() {
      _offset = _scrollController.offset;
    });
  }

  getComputedRadius(double screenHeight){
    if (_offset > screenHeight * 0.25){
      return 0.0;
    }
    return _topRadius - _offset * 0.25;
  }

  getOffsetAdvanceRatio(double screenHeight){
    //to slow down image shrinking, dividing _offset
    var modifiedOffset = (_offset / 4);
    if (modifiedOffset >= screenHeight * 0.25){
      return 1.0;
    }
    return (modifiedOffset / (screenHeight * 0.25));
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("images/fluff.png"), fit: BoxFit.cover),
                      ),
                      // the more we advance, the smaller it should get (1 - ratio)
                      height: screenHeight * (_headerPercentHeight * (1 - getOffsetAdvanceRatio(screenHeight))),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Next: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("data")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      child: Container(
                        //The more we advance, the bigger it get
                        height: screenHeight * ((1 -_headerPercentHeight) + (getOffsetAdvanceRatio(screenHeight))),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.richBlack,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(getComputedRadius(screenHeight)),
                                  topRight: Radius.circular(getComputedRadius(screenHeight)))),
                          child: Padding(
                            padding: EdgeInsets.all(_topRadius / 4 + 8.0),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        children: List.generate(
                                            20,
                                                (index) => ListTile(
                                              title: Text(
                                                index.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(onScroll);
    _scrollController.dispose();
  }
}
